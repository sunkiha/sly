package controller;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import comm.BaseController;

public class AdminController extends BaseController {
	public void index() {
		Record record=getUser();
		if(record==null){
		  render("../login.jsp");
		}else{
		  render("../admin.jsp");
		}
	}
	public void wap(){
		render("../weixinpub/admin/login.jsp");
	}
	
	public void menu(){
		int type = getUser().getInt("type");
		List<Record> recordList = null;
		if (type == 0) {// 超级管理员
			recordList = Db.find("SELECT * FROM `left_menu` where admin=1");
		} else {
			recordList = Db
					.find("SELECT * FROM `left_menu` where normal=1");
		}
		renderJson(recordList);
	}
	public void menuWap(){
		int type = getUser().getInt("type");
		List<Record> recordList = null;
		if (type == 0) {// 超级管理员
			recordList = Db.find("SELECT * FROM `left_menu_wap` where admin=1");
		} else {
			recordList = Db
					.find("SELECT * FROM `left_menu_wap` where normal=1");
		}
		renderJson(recordList);
	}
	public void loginDestory(){
		setAttr("msg", "登录失效");
		render("../msg.jsp");
	}
}
