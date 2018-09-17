package controller.userInfo;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class UserInfoController extends BaseController {
	JSONObject rm;

	public void index() {
		render("index.jsp");
	}

	public void toAdd() {
		render("add.jsp");
	}

	public void add() {
		String username = getPara("username");
		String password = getPara("password");
		String phone = getPara("phone");
		String qq = getPara("qq");
		Record record = new RecordBean();
		record.set("username", username);
		record.set("password", password);
		record.set("phone", phone);
		record.set("qq", qq);
		Db.save("userInfo", record);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}

	public void getUserInfoPage() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String username = getPara("username");
		StringBuffer where = new StringBuffer(" where ");
		where.append("1=1");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(username)) {
			where.append(" and username  like ?");
			paras.add("%" + username + "%");
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"select *", "from userInfo " + where.toString() + " order by "
						+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void login() {
		render("../login.jsp");
	}

	public void loginP() {
		String userName = getPara("username");
		String password = getPara("password");
		Record record = Db
				.findFirst(
						"SELECT * FROM `manager` where username=? and password=? and status=0",
						userName, password);
		JSONObject rm = new JSONObject();
		if (record != null) {
			setUser(record);
			int type = record.getInt("type");
			List<Record> recordList = null;
			if (type == 0) {// 超级管理员
				recordList = Db.find("SELECT * FROM `left_menu` where admin=1");
			} else {
				recordList = Db
						.find("SELECT * FROM `left_menu` where normal=1");
			}

			setSessionAttr("leftMenu", JsonKit.toJson(recordList));
			rm.put(S.code, 1);
			rm.put(S.msg, "登录成功");
		} else {
			rm.put(S.code, 0);
			rm.put(S.msg, "登录失败");
		}
		renderJson(rm);
	}

	public void loginOut() {
		exitUser();
		redirect("/admin");
	}

	public void deleteById() {
		String id = getPara("id");
		Db.update("update userInfo set status=1 where id=?", id);
		renderText("冻结成功");
	}

	public void jieDongById() {
		String id = getPara("id");
		Db.update("update userInfo set status=0 where id=?", id);
		renderText("解冻成功");
	}

	public void userLoginAccount() {
		render("userLoginAccount.jsp");
	}

	public void getAppLoginAccount() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String date = getPara("date");
		StringBuffer where = new StringBuffer(" where ");
		where.append("1=1");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(date)) {
			where.append(" and DATE_FORMAT(loginDate,'%Y-%m-%d')=?");
			paras.add(date);
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"SELECT username,nickname,loginDate ", "FROM `loginlog` "
						+ where.toString() + " order by " + sortField + " "
						+ sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	
	
	public void loginOutWap(){
		exitUser();
		render("../weixinpub/admin/login.jsp");
	}
}
