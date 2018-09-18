package manager.controller;

import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import comm.BaseController;
import comm.Mail;
import comm.RecordBean;
import comm.S;

public class ManagerController extends BaseController {
	public void loginView() {
		render("../login.jsp");
	}

	public void login() {
		String userName = getPara("username");
		String password = getPara("password");
		Record record = Db.findFirst("SELECT * FROM `manager` where username=? and password=? ", userName, password);
		JSONObject rm = new JSONObject();
		if (record != null) {
			String status = record.getStr("status");
			if ("0".equals(status)) {
				rm.put(S.code, 0);
				rm.put(S.msg, "请等待管理员审核");
			} else if ("2".equals(status)) {
				setUser(record);
				rm.put(S.code, 1);
				rm.put(S.msg, "登录成功");
				if ("ad".equals(getPara("os"))) {
					rm.put("data", record);
				} else {
					rm.put("userInfo", record);
				}
			} else if ("3".equals(status)) {
				String reason = record.getStr("reason");
				rm.put(S.code, 0);
				rm.put(S.msg, reason);
			}
			/*
			 * int id = record.getInt("id"); List<Record> recordList = Db
			 * .find("SELECT mn.id,mn.`name`,mn.parentId,mn.url FROM manager m,power p,menu mn where p.roleId=m.roleId and mn.id=p.menuId and m.id=?"
			 * , id); setSessionAttr("leftMenu", JsonKit.toJson(recordList));
			 * System.out.println(JsonKit.toJson(recordList));
			 */

		} else {
			rm.put(S.code, 0);
			rm.put(S.msg, "登录失败");
		}

		renderJson(rm);
	}

	public void register() {
		String userName = getPara("username");
		String password = getPara("password");
		String ecode = getPara("ecode");
		String email = getPara("email");
		String type = getPara("type");
		JSONObject rm = new JSONObject();
		Record recordMager = Db.findFirst("SELECT * FROM `manager` where username=? or email=?", userName, email);
		if (recordMager != null) {
			rm.put(S.code, 0);
			rm.put(S.msg, "该帐号或邮箱已存在");
			renderJson(rm);
		} else {
			Record emialcodeRd = Db.findFirst(
					"SELECT code FROM `emailcode` where code=? and username=? and type=1 ORDER BY id desc", ecode,
					userName);
			if (emialcodeRd == null || !emialcodeRd.getStr("code").equals(ecode)) {
				rm.put(S.code, 0);
				rm.put(S.msg, "验证码错误");
			} else {
				Record record = new RecordBean();
				record.set("username", userName);
				record.set("email", email);
				record.set("type", type);
				record.set("roleId", type);
				record.set("password", password);
				Db.save("manager", record);

				rm.put(S.code, 1);
				rm.put(S.msg, "注册成功");
			}
			renderJson(rm);
		}
	}

	public void sendMail() {
		String userName = getPara("username");
		String email = getPara("email");
		Record recordMager = Db.findFirst("SELECT * FROM `manager` where username=? or email=?", userName, email);
		JSONObject rm = new JSONObject();
		if (recordMager != null) {
			rm.put(S.code, 0);
			rm.put(S.msg, "该帐号或邮箱已存在");
			renderJson(rm);
		} else {
			Record record = new Record();
			record.set("username", userName);
			record.set("email", email);
			int code = (int) ((Math.random() * 9 + 1) * 1000);
			record.set("code", code);
			long currentTime = System.currentTimeMillis();
			currentTime += 30 * 60 * 1000;
			record.set("deadTime", currentTime);
			record.set("type", 1);// 注册
			Db.save("emailcode", record);
			Mail mail = new Mail();
			mail.sendMail(email, "注册验证码" + code, "欢迎注册本系统");
			rm.put(S.code, 1);
			rm.put(S.msg, "邮件发送成功,注意查收验证码");
			renderJson(rm);
		}
	}

	public void sendMail2() {
		String userName = getPara("username");
		Record recordMager = Db.findFirst("SELECT * FROM `manager` where username=?", userName);
		JSONObject rm = new JSONObject();
		if (recordMager == null) {
			rm.put(S.code, 0);
			rm.put(S.msg, "该帐号不存在");
			renderJson(rm);
		} else {
			String email = recordMager.getStr("email");
			Record record = new Record();
			record.set("username", userName);
			record.set("email", email);
			int code = (int) ((Math.random() * 9 + 1) * 1000);
			record.set("code", code);
			long currentTime = System.currentTimeMillis();
			currentTime += 30 * 60 * 1000;
			record.set("deadTime", currentTime);
			record.set("type", 2);// 密码重置
			Db.save("emailcode", record);
			Mail mail = new Mail();
			mail.sendMail(email, "重置验证码" + code, "密码重置验证码");
			rm.put(S.code, 1);
			rm.put(S.msg, "邮件发送成功,注意查收验证码");
			renderJson(rm);
		}
	}

	public void forgetPwd() {
		String userName = getPara("username");
		String password = getPara("password");
		String ecode = getPara("ecode");
		JSONObject rm = new JSONObject();
		Record recordMager = Db.findFirst("SELECT * FROM `manager` where username=?", userName);
		if (recordMager == null) {
			rm.put(S.code, 0);
			rm.put(S.msg, "该帐号不存在");
			renderJson(rm);
		} else {
			Record emialcodeRd = Db.findFirst(
					"SELECT code FROM `emailcode` where code=? and username=? and type=2 ORDER BY id desc", ecode,
					userName);
			if (emialcodeRd == null || !emialcodeRd.getStr("code").equals(ecode)) {
				rm.put(S.code, 0);
				rm.put(S.msg, "验证码错误");
			} else {
				Db.update("update manager set password=? where username=?", password, userName);
				rm.put(S.code, 1);
				rm.put(S.msg, "修改成功");
			}
			renderJson(rm);
		}
	}

	public void getManagerById() {
		Record r = getUser();
		int id = r.getInt("id");
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

	// 完善资料
	public void myPersonPerfect() {
		String uname = getPara("uname");
		String sex = getPara("sex");
		String age = getPara("age");
		int id = getUser().getInt("id");
		Db.update("update manager set uname=? , sex=? , age=? where id=?", uname, sex, age, id);
		JSONObject rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "保存成功");
		renderJson(rm);
	}
}
