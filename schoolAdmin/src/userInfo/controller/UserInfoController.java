package userInfo.controller;

import java.io.IOException;
import java.util.Map;

import userInfo.bean.UserInfo;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.ehcache.CacheKit;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class UserInfoController extends BaseController {
	public void loginView(){
		render("../login.jsp");
	}
	public void login() throws IOException {
		String data = getRequestBody();
		CacheKit.put("session", "TOKEN1", "Sd");
		String a = CacheKit.get("session", "TOKEN1");
		/*
		 * if(S.notEmpty(a)){ System.out.println(a); }else{
		 * CacheKit.put("session","TOKEN1","Sd"); }
		 */

		// 登录
		/*
		 * Record userInfoRd = new RecordBean(); userInfoRd.set("type", 0);
		 * userInfoRd.set("status", 0); userInfoRd.set("os", main.getOs());
		 * Record userInfoRdOut = null; // 无账户 imsi if
		 * (S.notEmpty(main.getImsi())) { userInfoRd.set("imsi",
		 * main.getImsi()); userInfoRdOut = Db.findFirst(
		 * "select type from userInfo where imsi=?", main.getImsi()); if
		 * (userInfoRdOut == null) { boolean isSave = Db.save("userInfo",
		 * userInfoRd); } userInfoRdOut = Db.findFirst(
		 * "select type from userInfo where imsi=?", main.getImsi()); }
		 */
		UserInfo userInfo = JSON.parseObject(data, UserInfo.class);
		String password = userInfo.getPwd();
		String phone = userInfo.getPhone();
		Record record = Db.findFirst(
				"SELECT * FROM `userInfo` where phone=? and pwd=?", phone,
				S.MD5(password));
		JSONObject rm;
		if (record != null) {
			// setSessionAttr("userInfo", record);
			String token = v(S.oid());// 获取唯一token
			CacheKit.put("session", token, record.getInt("id"));// 保存token信息
			JSONObject m=new JSONObject();
			m.put("token", token);
			rm = getOk();
			rm.put("data", m);
			rm.put(S.code, 3);
			rm.put(S.msg, "登录成功");
		} else {
			rm = getError();
			rm.put(S.code, 4);
			rm.put(S.msg, "帐号或密码错误");
		}

		renderJson(rm);
	}

	private String v(String token) {
		String a = CacheKit.get("session", token);
		if (S.notEmpty(a)) {
			return v(S.oid());
		} else {
			return token;
		}
	}

	public void register() throws IOException {
		JSONObject rm;
		String data = getRequestBody();
		UserInfo userInfo = JSON.parseObject(data, UserInfo.class);
		String password = userInfo.getPwd();
		String phone = userInfo.getPhone();

		/*
		 * if (!S.notEmpty(userName)) { rm = getError(); rm.put(S.msg,
		 * "帐号不能为空"); renderJson(rm); return; } else if (userName.length() < 3
		 * || userName.length() > 16) { rm = getError(); rm.put(S.msg,
		 * "用户长度在3到16位之间"); renderJson(rm); return; }
		 */

		if (!S.notEmpty(phone)) {
			rm = getError();
			rm.put(S.msg, "电话不能为空");
			renderJson(rm);
			return;
		} else if (!phone.matches("^1[3|4|5|8][0-9]\\d{8}$")) {
			rm = getError();
			rm.put(S.msg, "电话格式错误");
			renderJson(rm);
			return;
		}
		if (!S.notEmpty(password)) {
			rm = getError();
			rm.put(S.msg, "密码不能为空");
			renderJson(rm);
			return;
		} else if (password.length() < 6 || password.length() > 16) {
			rm = getError();
			rm.put(S.msg, "密码长度在6到16位之间");
			renderJson(rm);
			return;
		}
		Record reUserInfo = new RecordBean();
		reUserInfo.setColumns(JSON.parseObject(data, Map.class));
		reUserInfo.set("phone", phone);
		reUserInfo.set("pwd", S.MD5(password));// 再加密一次
		Record record = Db.findFirst("SELECT * FROM `userInfo` where phone=?",
				phone);
		if (record != null) {
			rm = getError();
			rm.put(S.msg, "该用户已经存在");
		} else {
			boolean bl = Db.save("userInfo", reUserInfo);
			if (bl) {
				rm = getOk();
				rm.put(S.msg, "注册成功");
			} else {
				rm = getError();
				rm.put(S.msg, "注册失败");
			}
		}
		renderJson(rm);
	}

	public void modPwd() {
		JSONObject rm;
		Record record = getUser();
		Object userName = record.get("username");
		String password = record.get("password");
		String oldPassword = getPara("oldPassword");
		String newPassword = getPara("newPassword");
		if (!password.equals(oldPassword)) {
			rm = getError();
			rm.put(S.msg, "原密码错误");
		} else {
			Record userInfo = new Record();
			userInfo.set("id", record.get("id"));
			userInfo.set("username", userName);
			userInfo.set("password", newPassword);
			Db.update("userInfo", userInfo);
			rm = getOk();
			rm.put(S.msg, "修改成功");
			record.set("password", newPassword);
		}
		renderJson(rm);
	}
}
