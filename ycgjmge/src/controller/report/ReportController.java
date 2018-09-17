package controller.report;

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
//举报 type 0帖子 1 评论
public class ReportController extends BaseController {
	JSONObject rm;
	public void reportList() {
		int type=getParaToInt("type");
		if(type==0){//帖子
			render("reportCommPostList.jsp");
		}else{
			render("reportCommPostCommentList.jsp");
		}
	}
	public void toAddPregnancyCheck() {
		render("addPregnancyCheck.jsp");
	}
	public void toModPregnancyCheck() {
		render("modPregnancyCheck.jsp");
	}

	public void addPregnancyCheck() {
		UploadFile uFile=getFile("banner");
		String banner=S.oid();
		Record pregnancyCheck=new RecordBean();
		if(uFile!=null){
			File file=new File("F:/yunyu/"+banner+".png");
			uFile.getFile().renameTo(file);
		}
		String name=getPara("name");
		String desc=getPara("desc");
		String normalCheck=getPara("normalCheck");
		String assay=getPara("assay");
		String assistCheck=getPara("assistCheck");
		String min=getPara("min");
		String max=getPara("max");
		pregnancyCheck.set("banner", banner);
		pregnancyCheck.set("name",name);
		pregnancyCheck.set("desc", desc);
		pregnancyCheck.set("normalCheck", normalCheck);
		pregnancyCheck.set("assay", assay);
		pregnancyCheck.set("assistCheck", assistCheck);
		pregnancyCheck.set("min", min);
		pregnancyCheck.set("max", max);
		pregnancyCheck.set("createDate", new Date());
		Db.save("pregnancy_check", pregnancyCheck);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}
	public void modPregnancyCheck() {
		UploadFile uFile=getFile("bannertmp");
		String id=getPara("id");
		String banner=getPara("banner");
		Record pregnancyCheck=new RecordBean();
		if(uFile!=null){
			File file=new File("F:/yunyu/"+banner+".png");
			if(file.exists()){
				file.delete();
			}
			uFile.getFile().renameTo(file);
		}
		String name=getPara("name");
		String desc=getPara("desc");
		String normalCheck=getPara("normalCheck");
		String assay=getPara("assay");
		String assistCheck=getPara("assistCheck");
		String min=getPara("min");
		String max=getPara("max");
		
		pregnancyCheck.set("id",id);
		pregnancyCheck.set("name",name);
		pregnancyCheck.set("desc", desc);
		pregnancyCheck.set("normalCheck", normalCheck);
		pregnancyCheck.set("assay", assay);
		pregnancyCheck.set("assistCheck", assistCheck);
		pregnancyCheck.set("min", min);
		pregnancyCheck.set("max", max);
		pregnancyCheck.set("createDate", new Date());
		Db.update("pregnancy_check", pregnancyCheck);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}
	
	
	//json-----
	public void getReportCommPostList() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		StringBuffer where = new StringBuffer(" where ");
		where.append("r.type=1 and u.id=r.userInfoId and r.fid=cp.id and ui.id=cp.userInfoId");
		List<Object> paras = new ArrayList<Object>();
		/*
		 * if(S.notEmpty(week)){ where.append(" and week=?"); paras.add(week); }
		 */
		Page<Record> userInfoPage = Db
				.paginate(
						pageNumber,
						pageSize,
						"SELECT r.*,count(fid) reportNum,cp.content,u.username reportUserName,ui.username,cp.id communitypostId",
						"FROM `report` r,communitypost cp,userinfo u,userinfo ui"
								+ where.toString() + " GROUP BY r.fid order by "
								+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	public void getReportCommPostCommentList() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		StringBuffer where = new StringBuffer(" where ");
		where.append("r.type=0 and u.id=r.userInfoId and r.fid=cp.id and ui.id=cp.userInfoId");
		List<Object> paras = new ArrayList<Object>();
		/*
		 * if(S.notEmpty(week)){ where.append(" and week=?"); paras.add(week); }
		 */
		Page<Record> userInfoPage = Db
				.paginate(
						pageNumber,
						pageSize,
						"SELECT r.*,count(fid) reportNum,cp.content,u.username reportUserName,ui.username,cp.id communitypostCommentId",
						"FROM `report` r,communitypostcomment cp,userinfo u,userinfo ui"
								+ where.toString() + " GROUP BY r.fid order by "
								+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	//举报处理
	public void delCommunitypost(){
		String communitypostId=getPara("communitypostId");
		String reportId=getPara("reportId");
		Db.update("update communitypost set status=1 where id=?",communitypostId);
		Db.update("update report set status=1 where id=?",reportId);
		renderText("删除成功");
	}
	public void delCommunitypostComment() {
		String communitypostCommentId=getPara("communitypostCommentId");
		String reportId=getPara("reportId");
		Db.update("update communitypostcomment set status=1 where id=?",communitypostCommentId);
		Db.update("update report set status=1 where id=?",reportId);
		renderText("删除成功");
	}
}
