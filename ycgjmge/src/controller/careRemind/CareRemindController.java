package controller.careRemind;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import comm.BaseController;
import comm.M;
import comm.RecordBean;
import comm.S;

public class CareRemindController extends BaseController {
	JSONObject rm;

	public void beiyunList() {
		render("beiyunList.jsp");
	}

	public void huaiyunList() {
		render("huaiyunList.jsp");
	}

	public void toAdd() {
		render("add.jsp");
	}

	public void toAddBeiyun() {
		render("addBeiyun.jsp");
	}

	public void toModBeiyun() {
		render("modBeiyun.jsp");
	}

	public void toModHuaiyun() {
		render("modHuaiyun.jsp");
	}

	public void getHuaiYunList() {
		String week = getPara("week");
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		StringBuffer where = new StringBuffer(" where ");
		where.append(" 1=1 ");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(week)) {
			where.append(" and weekNum=?");
			paras.add(week);
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"select *", "from careremind_huaiyun " + where.toString()
						+ " order by " + sortField + " " + sortOrder,
				paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void getBeiYunList() {
		String day = getPara("day");
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		StringBuffer where = new StringBuffer(" where ");
		where.append(" 1=1 ");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(day)) {
			where.append(" and day=?");
			paras.add(day);
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"select *", "from careremind_beiyun " + where.toString()
						+ " order by " + sortField + " " + sortOrder,
				paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void getHuaiyunById() {
		String id = getPara("id");
		Record rd = Db.findFirst("select * from careremind_huaiyun where id=?",
				id);
		renderJson(rd);
	}

	public void getBeiyunById() {
		String id = getPara("id");
		Record rd = Db.findFirst("select * from careremind_beiyun where id=?",
				id);
		renderJson(rd);
	}

	public void addHuaiyun() {
		UploadFile uFile = getFile("statusPic");
		String week = getPara("week");
		Record rd = Db.findFirst(
				"select * from careremind_huaiyun where weekNum=?", week);
		if (rd != null) {
			setAttr("msg", "此周已经添加");
			render("../msg.jsp");
			return;
		}
		String statusPic;
		Record huaiyunRemind = new RecordBean();
		if (uFile != null) {
			statusPic = S.oid();
			huaiyunRemind.set("statusPic", statusPic);
			File file = new File("F:/yunyu/" + statusPic + ".png");
			uFile.getFile().renameTo(file);
		}

		String talk = getPara("talk");
		huaiyunRemind.set("weekNum", week);
		huaiyunRemind.set("talk", talk);
		Db.save("careremind_huaiyun", huaiyunRemind);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}

	public void addBeiyun() {
		UploadFile uFile = getFile("statusPic");
		int day = getParaToInt("day");
		Record rd = Db.findFirst("select * from careremind_beiyun where day=?",
				day);
		if (rd != null) {
			setAttr("msg", "此天数已经添加");
			render("../msg.jsp");
			return;
		}
		String statusPic;
		Record huaiyunRemind = new RecordBean();
		if (uFile != null) {
			statusPic = S.oid();
			huaiyunRemind.set("statusPic", statusPic);
			File file = new File("F:/yunyu/" + statusPic + ".png");
			uFile.getFile().renameTo(file);
		}
		String talk = getPara("talk");
		huaiyunRemind.set("day", day);
		huaiyunRemind.set("talk", talk);
		Db.save("careremind_beiyun", huaiyunRemind);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}

	public void modHuaiyun() {
		UploadFile uFile = getFile("statusPic");
		String id = getPara("id");
		String week = getPara("weekNum");
		Record rd = Db.findFirst(
				"select * from careremind_huaiyun where weekNum=?", week);
		if (rd != null) {
			String idt = rd.get("id") + "";
			if (!id.equals(idt)) {// 当前的id不等于当前周数的id 说明已经有此周
				setAttr("msg", "此周已经添加");
				render("../msg.jsp");
				return;
			}
			Record huaiyunRemind = new RecordBean();
			if (uFile != null) {
				String statusPic = rd.getStr("statusPic");
				huaiyunRemind.set("statusPic", statusPic);
				File file = new File("F:/yunyu/" + statusPic + ".png");
				if(file.exists()){
					file.delete();
				}
				uFile.getFile().renameTo(file);
			}

			String talk = getPara("talk");
			huaiyunRemind.set("id", id);
			huaiyunRemind.set("weekNum", week);
			huaiyunRemind.set("talk", talk);
			Db.update("careremind_huaiyun", huaiyunRemind);
			setAttr("msg", "修改成功");
			render("../msg.jsp");
		}

	}

	public void modBeiyun() {
		UploadFile uFile = getFile("statusPic");
		String id = getPara("id");
		int day = getParaToInt("day");
		Record rd = Db.findFirst("select * from careremind_beiyun where day=?",
				day);
		if (rd != null) {
			String idt = rd.get("id") + "";
			if (!id.equals(idt)) {// 当前的id不等于当前周数的id 说明已经有此周
				setAttr("msg", "此天已经添加");
				render("../msg.jsp");
				return;
			}
		}
		String statusPic;
		Record huaiyunRemind = new RecordBean();
		if (uFile != null) {
			statusPic = S.oid();
			huaiyunRemind.set("statusPic", statusPic);
			File file = new File("F:/yunyu/" + statusPic + ".png");
			uFile.getFile().renameTo(file);
		}

		String talk = getPara("talk");
		huaiyunRemind.set("id", id);
		huaiyunRemind.set("day", day);
		huaiyunRemind.set("talk", talk);
		Db.update("careremind_beiyun", huaiyunRemind);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}

	public void deleteBeiyunCareRemindById() {
		String id = getPara("id");
		Db.deleteById("careremind_beiyun", id);
		renderText("删除成功");
	}

	public void deleteHuaiyunCareRemindById() {
		String id = getPara("id");
		Db.deleteById("careremind_huaiyun", id);
		renderText("删除成功");
	}

	public void getHomeMenuById() {
		String id = getPara("id");
		Record record = Db.findById("homemenu_content", id);
		renderJson(record);
	}

	public void getWeeks() {
		M m = null;
		List<M> weekList = new ArrayList<M>();
		for (int i = 0; i < 51; i++) {
			m = new M();
			m.put("name", "第" + i + "周");
			m.put("value", i);
			weekList.add(m);
		}
		renderJson(weekList);
	}

	public void getDays() {
		M m = null;
		List<M> weekList = new ArrayList<M>();
		for (int i = 1; i < 51; i++) {
			m = new M();
			m.put("name", "第" + i + "天");
			m.put("value", i);
			weekList.add(m);
		}
		renderJson(weekList);
	}
}
