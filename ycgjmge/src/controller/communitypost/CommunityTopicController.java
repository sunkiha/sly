package controller.communitypost;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

/*
 * 话题
 */

public class CommunityTopicController extends BaseController {
	JSONObject rm;
	public void communityTopicList() {
		render("communityTopicList.jsp");
	}
	public void toAddCommunityTopic() {
		render("addCommunityTopic.jsp");
	}
	public void toModCommunityTopic() {
		String id=getPara("id");
		setAttr("id", id);
		render("modCommunityTopic.jsp");
	}
	public void modCommunityTopic(){
		UploadFile uFile=getFile("imgTmp");
		String img=getPara("img");
		Record communityTopic=new RecordBean();
		if(uFile!=null){
			File file=new File("F:/yunyu/"+img+".png");
			if(file.exists()){
				file.delete();
			}
			uFile.getFile().renameTo(file);
		}
		String id=getPara("id");
		String name=getPara("name");
		String desc=getPara("desc");
		communityTopic.set("id", id);
		communityTopic.set("img", img);
		communityTopic.set("name",name);
		communityTopic.set("desc", desc);
		communityTopic.set("createDate", new Date());
		Db.update("communitytopic", communityTopic);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}
	public void addCommunityTopic() {
		UploadFile uFile=getFile("img");
		String img=S.oid();
		Record communityTopic=new RecordBean();
		if(uFile!=null){
			File file=new File("F:/yunyu/"+img+".png");
			uFile.getFile().renameTo(file);
		}
		String name=getPara("name");
		String desc=getPara("desc");
		communityTopic.set("img", img);
		communityTopic.set("name",name);
		communityTopic.set("desc", desc);
		communityTopic.set("createDate", new Date());
		Db.save("communitytopic", communityTopic);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}
	public void delCommunityTopic() {
		String id = getPara("id");
		Db.update("update communitytopic set status=1 where id=?", id);
		renderText("删除成功");
	}
	public void getCommunityTopicList() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		List<Object> paras = new ArrayList<Object>();
		StringBuffer where = new StringBuffer(" where ");
		where.append("status=0 ");
		//paras.add(id);
		/*
		 * if(S.notEmpty(week)){ where.append(" and week=?"); paras.add(week); }
		 */
		Page<Record> replyPage = Db.paginate(
				pageNumber,
				pageSize,
				"SELECT id,name,`desc`,img,createDate ",
				"FROM `communitytopic` "
						+ where.toString() + " order by " + sortField + " "
						+ sortOrder, paras.toArray());
		rm.put("data", replyPage.getList());
		rm.put("total", replyPage.getTotalRow());
		renderJson(rm);
	}
	public void getCommunityTopicById(){
		String id=getPara("id");
		Record record=Db.findById("communitytopic",id);
		renderJson(record);
	}
}
