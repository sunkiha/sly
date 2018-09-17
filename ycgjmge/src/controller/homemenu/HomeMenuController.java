package controller.homemenu;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class HomeMenuController extends BaseController {
	JSONObject rm;
	public void index(){
		String homeMenuId=getPara("homeMenuId");
		setAttr("homeMenuId", homeMenuId);
		render("index.jsp");
	}
	public void toAdd(){
		String homeMenuId=getPara("homeMenuId");
		setAttr("homeMenuId", homeMenuId);
		render("add.jsp");
	}
	public void toMod(){
		/*String homeMenuId=getPara("homeMenuId");
		setAttr("homeMenuId", homeMenuId);*/
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
		String homeMenuId=getPara("homeMenuId");
		String summary=getPara("summary");
		String title=getPara("title");
		String content=getPara("content");
		equipment.set("title", title);
		equipment.set("content", content);
		equipment.set("summary", summary);
		equipment.set("homeMenuId", homeMenuId);
		Db.save("homemenu_content", equipment);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}
	public void mod(){
		UploadFile uFile=getFile("bannertmp");
		String id=getPara("id");
		String title=getPara("title");
		String banner=getPara("banner");
		String content=getPara("content");
		String summary=getPara("summary");
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
		equipment.set("summary", summary);
		Db.update("homemenu_content", equipment);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}
	public void deleteById(){
		String id=getPara("id");
		Db.update("update homemenu_content set status=1 where id=?",id);
		renderText("删除成功");
	}
	public void getHomeMenuContentPage(){
		rm = new JSONObject();
		int pageNumber=getParaToInt("pageIndex",0)+1;
		int pageSize=getParaToInt("pageSize"); 
		String sortField=getPara("sortField");
		String sortOrder=getPara("sortOrder");
		String title=getPara("title");
		String homeMenuId=getPara("homeMenuId");
		StringBuffer where=new StringBuffer(" where ");
		where.append("status=0");
		List<Object> paras=new ArrayList<Object>();
		where.append(" and homeMenuId=? ");
		paras.add(homeMenuId);
		if(S.notEmpty(title)){
			where.append(" and title  like ?");
			paras.add("%"+title+"%");
		}
		Page<Record> userInfoPage=Db.paginate(pageNumber, pageSize, "select *", "from homemenu_content "+where.toString()+" order by "+sortField+" "+sortOrder,paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	public void getHomeMenuById(){
		String id=getPara("id");
		Record record=Db.findById("homemenu_content", id);
		renderJson(record);
	}
}
