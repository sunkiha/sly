package controller.managerclient;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class ManagerclientController extends BaseController {
	JSONObject rm;

	public void toPerson() {
		String id = getPara("id");
		Record rd = Db.findById("manager", id);
		setAttr("magerclient", rd);
		render("person.jsp");
	}

	public void personUpdate() {
		String id = getPara("id");
		String status = getPara("status");
		Db.update("update manager set status=? where id=?", status, id);
		rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "更新成功");
		renderJson(rm);
	}

	public void getUserInfoById() {
		int id = getParaToInt("id");
		Record rd = Db.findById("manager", id);
		JSONObject rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "成功");
		if ("ad".equals(getPara("os"))) {
			rm.put("data", rd);
		} else {
			rm.put("manager", rd);
		}
		renderJson(rm);
	}

	public void remSet() {
		Db.update("delete from seg");
		for (int i = 1; i < 6; i++) {
			String[] m = getParaValues("z" + i);
			String date1s = getPara("date" + i + "s");
			String date1e = getPara("date" + i + "e");
			if (m != null) {
				for (String string : m) {
					Record r = new RecordBean();
					r.set("startTime", date1s);
					r.set("endTime", date1e);
					r.set("segDay", i);
					if (i == 1) {
						r.set("segDayZh", "周一");
					} else if (i == 2) {
						r.set("segDayZh", "周二");
					} else if (i == 3) {
						r.set("segDayZh", "周三");
					} else if (i == 4) {
						r.set("segDayZh", "周四");
					} else if (i == 5) {
						r.set("segDayZh", "周五");
					}
					r.set("num", string);
					Db.save("seg", r);
				}
			}
		}

		redirect("/managerclient/toRebSet");
	}

	public void toRebSet() {
		List<Record> rl = Db.find("select * from seg");
		if (rl != null) {
			for (Record record : rl) {
				String regDay = record.getStr("segDay");
				// if("1".equals(regDay)) {
				String num = record.getStr("num");
				String startTime = record.getStr("startTime");
				String endTime = record.getStr("endTime");
				setAttr("z" + regDay + "_" + num, "checked='checked'");
				setAttr("date" + regDay + "s", startTime);
				setAttr("date" + regDay + "e", endTime);
				// }
			}
		}

		render("reimburseme_seting.jsp");
	}

	public void getSeg() {
		List li=Db.find("SELECT CONCAT_WS(',窗口',segDayZh,num)name FROM `seg`");
		if ("ad".equals(getPara("os"))) {
			Map rm = new HashMap();
			Map m=new HashMap();
			m.put("list", li);
			rm.put("data", m);
			rm.put(S.code, 1);
			rm.put(S.msg, "成功");
			renderJson(rm);
		} else {
			renderJson(li);
		}
	}

	public void tj() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date to1 = getThisWeekMonday();
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(to1);
		calendar.add(calendar.DATE, 1);// 把日期往后增加一天.整数往后推,负数往前移动
		String toDay = sf.format(to1);
		String day2 = sf.format(calendar.getTime());
		calendar.add(calendar.DATE, 1);
		String day3 = sf.format(calendar.getTime());
		calendar.add(calendar.DATE, 1);
		String day4 = sf.format(calendar.getTime());
		calendar.add(calendar.DATE, 1);
		String day5 = sf.format(calendar.getTime());
		System.out.println(day3);
		double d1 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", toDay);
		double d2 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", day2);
		double d3 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", day3);
		double d4 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", day4);
		double d5 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", day5);

		setAttr("d", "[" + d1 + ", " + d2 + ", " + d3 + ", " + d4 + ", " + d5 + "]");
		render("chart.jsp");
	}

	public void tjapp() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date to1 = getThisWeekMonday();
		Calendar calendar = new GregorianCalendar();
		calendar.setTime(to1);
		calendar.add(calendar.DATE, 1);// 把日期往后增加一天.整数往后推,负数往前移动
		String toDay = sf.format(to1);
		String day2 = sf.format(calendar.getTime());
		calendar.add(calendar.DATE, 1);
		String day3 = sf.format(calendar.getTime());
		calendar.add(calendar.DATE, 1);
		String day4 = sf.format(calendar.getTime());
		calendar.add(calendar.DATE, 1);
		String day5 = sf.format(calendar.getTime());
		System.out.println(day3);
		double d1 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", toDay);
		double d2 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", day2);
		double d3 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", day3);
		double d4 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", day4);
		double d5 = Db.queryDouble(
				"SELECT IFNULL(SUM(money),0) d FROM `reimburseme` where date_format(modDate,'%Y-%m-%d')=? ", day5);

		rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "成功");

		if ("ad".equals(getPara("os"))) {
			Map m = new HashMap<>();
			m.put("d1", d1);
			m.put("d2", d2);
			m.put("d3", d3);
			m.put("d4", d4);
			m.put("d5", d5);
			rm.put("data", m);
		} else {
			rm.put("d1", d1);
			rm.put("d2", d2);
			rm.put("d3", d3);
			rm.put("d4", d4);
			rm.put("d5", d5);
		}
		renderJson(rm);
	}

	Date getThisWeekMonday() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		// 获得当前日期是一个星期的第几天
		int dayWeek = cal.get(Calendar.DAY_OF_WEEK);
		if (1 == dayWeek) {
			cal.add(Calendar.DAY_OF_MONTH, -1);
		}
		// 设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一
		cal.setFirstDayOfWeek(Calendar.MONDAY);
		// 获得当前日期是一个星期的第几天
		int day = cal.get(Calendar.DAY_OF_WEEK);
		// 根据日历的规则，给当前日期减去星期几与一个星期第一天的差值
		cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);
		return cal.getTime();
	}

	public void getRegByDay() {
		int d = getParaToInt("day");

		rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "成功");
		rm.put("data", Db.find("SELECT * FROM `seg` where segDay=?", d));
		renderJson(rm);
	}
}
