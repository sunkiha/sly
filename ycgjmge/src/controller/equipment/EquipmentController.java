package controller.equipment;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.RecordBuilder;
import com.jfinal.upload.UploadFile;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class EquipmentController extends BaseController {
	JSONObject rm;
	public void index(){
		render("index.jsp");
	}
	public void toAddMod(){
		render("add_mod.jsp");
	}
	public void toMod(){
	/*	String id=getPara("id");
		if(S.notEmpty(id)){
			Record record=Db.findById("equipment", id);
			setAttr("bean", record);
		}*/
		render("mod.jsp");
	}
	public void add(){
		UploadFile uFile=getFile("banner");
		String banner;
		Record equipment=new RecordBean();
		if(uFile!=null){
			banner=S.oid();
			equipment.set("banner", banner);
			File file=new File("F:/yunyu/zhongliu/"+banner+".png");
			uFile.getFile().renameTo(file);
		}
		String title=getPara("title");
		String content=getPara("content");
		equipment.set("title", title);
		equipment.set("content", content);
		Db.save("equipment", equipment);
		renderHtml("添加成功");
	}
	public void mod(){
		UploadFile uFile=getFile("bannertmp");
		String id=getPara("id");
		String title=getPara("title");
		String banner=getPara("banner");
		String content=getPara("content");
		Record equipment=new RecordBean();
		if(uFile!=null){
			File file=new File("F:/yunyu/zhongliu/"+banner+".png");
			if(file.exists()){
				file.delete();
			}
			uFile.getFile().renameTo(file);
		}
		equipment.set("id", id);
		equipment.set("title", title);
		equipment.set("content", content);
		Db.update("equipment", equipment);
		renderHtml("修改成功");
	}
	public void deleteById(){
		String id=getPara("id");
		Db.update("update equipment set status=1 where id=?",id);
		//setAttr("msg", "删除成功");
		//render("../msg.jsp");
		renderText("删除成功");
	}
	public void getEquipmentPage(){
		rm = new JSONObject();
		int pageNumber=getParaToInt("pageIndex",0)+1;
		int pageSize=getParaToInt("pageSize"); 
		String sortField=getPara("sortField");
		String sortOrder=getPara("sortOrder");
		String title=getPara("title");
		StringBuffer where=new StringBuffer(" where ");
		where.append("status=0");
		List<Object> paras=new ArrayList<Object>();
		if(S.notEmpty(title)){
			where.append(" and title  like ?");
			paras.add("%"+title+"%");
		}
		Page<Record> userInfoPage=Db.paginate(pageNumber, pageSize, "select *", "from equipment "+where.toString()+" order by "+sortField+" "+sortOrder,paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	public void getEquipmentById(){
		String id=getPara("id");
		Record record=Db.findById("equipment", id);
		renderJson(record);
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

	public void loginOut(){
		removeSessionAttr("userInfo");
	    redirect("/admin");
	}
}
