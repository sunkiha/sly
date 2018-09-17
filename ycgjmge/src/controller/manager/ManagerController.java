package controller.manager;

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

public class ManagerController extends BaseController {
	JSONObject rm;
	public void managerList(){
		render("manager_list.jsp");
	}
	public void toManagerAdd(){
		render("manager_add.jsp");
	}
	public void toManagerMod(){
		render("manager_mod.jsp");
	}
	public void login() {
		String userName = getPara("username");
		String password = getPara("password");
		Record record = Db.findFirst(
				"SELECT * FROM `admin` where username=? and password=?",
				userName, password);
		JSONObject rm = new JSONObject();
		if (record != null) {
			setSessionAttr("userInfo", record);
			List<Record> recordList = Db.find("SELECT * FROM `left_menu`");
			setSessionAttr("leftMenu",JsonKit.toJson(recordList));
			rm.put(S.code, 1);
			rm.put(S.msg, "登录成功");
		}else{
			rm.put(S.code, 0);
			rm.put(S.msg, "登录失败");
		}
		renderJson(rm);
	}

	public void managerAdd(){
		String username=getPara("username");
		String password=getPara("password");
		Record record=new RecordBean();
		record.set("username", username);
		record.set("password", password);
		Db.save("manager", record);
	    renderText("添加成功");
	}
	public void managerMod(){
		String id=getPara("id");
		Record manager=Db.findById("manager", id);
		String usernameTmp=manager.getStr("username");
		String username=getPara("username");
		String password=getPara("password");
		Record record=new RecordBean();
		record.set("id", id);
		if(!username.equals(usernameTmp)){
			record.set("username", username);
		}
		record.set("password", password);
		Db.update("manager", record);
		renderText("修改成功");
	}
	public void managerDel(){
		String id = getPara("id");
		Db.update("update manager set status=1 where id=?", id);
		renderText("删除成功");
	}
	public void getManagerList(){
		rm = new JSONObject();
		int pageNumber=getParaToInt("pageIndex",0)+1;
		int pageSize=getParaToInt("pageSize"); 
		String sortField=getPara("sortField");
		String sortOrder=getPara("sortOrder");
		String username=getPara("username");
		StringBuffer where=new StringBuffer(" where ");
		where.append("status=0 and type!=0 ");
		List<Object> paras=new ArrayList<Object>();
		if(S.notEmpty(username)){
			where.append(" and username  like ?");
			paras.add("%"+username+"%");
		}
		Page<Record> userInfoPage=Db.paginate(pageNumber, pageSize, "select id,username,password,createDate,type,status ", "from manager "+where.toString()+" order by "+sortField+" "+sortOrder,paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	public void getManagerById(){
		String id=getPara("id");
		Record record=Db.findById("manager", id);
		renderJson(record);
	}
}
