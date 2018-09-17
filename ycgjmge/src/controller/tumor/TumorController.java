package controller.tumor;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class TumorController extends BaseController {
	JSONObject rm;
	public void index(){
		render("index.jsp");
	}
	public void toAdd(){
		render("add.jsp");
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
		/*UploadFile uFile=getFile("banner");
		String banner;*/
		Record bean=new RecordBean();
		/*if(uFile!=null){
			banner=S.oid();
			equipment.set("banner", banner);
			File file=new File("F:/yunyu/zhongliu/"+banner+".png");
			uFile.getFile().renameTo(file);
		}*/
		String name=getPara("name");
		//String content=getPara("content");
		bean.set("name", name);
		//bean.set("content", content);
		Db.save("tumor", bean);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}
	public void mod(){
		//UploadFile uFile=getFile("bannertmp");
		String id=getPara("id");
		//String title=getPara("title");
		String name=getPara("name");
		//String content=getPara("content");
		Record bean=new RecordBean();
	/*	if(uFile!=null){
			File file=new File("F:/yunyu/zhongliu/"+banner+".png");
			if(file.exists()){
				file.delete();
			}
			uFile.getFile().renameTo(file);
		}*/
		bean.set("id", id);
		bean.set("name", name);
		//bean.set("content", content);
		Db.update("tumor", bean);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}
	public void deleteById(){
		String id=getPara("id");
		Db.update("update tumor set status=1 where id=?",id);
		//setAttr("msg", "删除成功");
		//render("../msg.jsp");
		renderText("删除成功");
	}
	public void getTumorPage(){
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
		Page<Record> userInfoPage=Db.paginate(pageNumber, pageSize, "select *", "from tumor "+where.toString()+" order by "+sortField+" "+sortOrder,paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	public void getTumorById(){
		String id=getPara("id");
		Record record=Db.findById("tumor", id);
		renderJson(record);
	}
}
