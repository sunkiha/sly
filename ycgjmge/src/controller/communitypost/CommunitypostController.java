package controller.communitypost;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import comm.BaseController;

public class CommunitypostController extends BaseController {
	JSONObject rm;
	public void communitypostList() {
		render("communitypostList.jsp");
	}
	public void toCommunitypostComment() {
		String cpId=getPara("cpId");
		setAttr("cpId", cpId);
		render("communitypostCommenList.jsp");
	}
	public void seeMoreImg() {
		String cpId=getPara("cpId");
		setAttr("cpId", cpId);
		render("communitypostImgList.jsp");
	}
	//json--
	public void delCommunitypost() {
		String id=getPara("id");
		Db.update("update communitypost set status=1 where id=?",id);
		renderText("删除成功");
	}
	public void deleteCommunitypostComment() {
		String id=getPara("id");
		Db.update("update communitypostcomment set status=1 where id=?",id);
		renderText("删除成功");
	}
	public void deleteCommunitypostImg() {
		String id=getPara("id");
		String path=getPara("path");
		Db.deleteById("communitypostimg", id);
		File file=new File("F:/yunyu/"+path+".png");
		file.delete();
		renderText("删除成功");
	}
	public void getCommunitypostList() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		List<Object> paras = new ArrayList<Object>();
		StringBuffer where = new StringBuffer();
		where.append("where cp.userInfoId=u.id and cp.`status`=0 ");
		//paras.add(id);
		/*
		 * if(S.notEmpty(week)){ where.append(" and week=?"); paras.add(week); }
		 */
		Page<Record> replyPage = Db.paginate(
				pageNumber,
				pageSize,
				"SELECT cp.id,cp.content,cp.createDate,u.username,(SELECT path from communitypostimg cpimg where cpimg.communityPostId=cp.id LIMIT 1) path ",
				"FROM `communitypost` cp,userinfo u "
						+ where.toString() + " order by " + sortField + " "
						+ sortOrder, paras.toArray());
		rm.put("data", replyPage.getList());
		rm.put("total", replyPage.getTotalRow());
		renderJson(rm);
	}
	public void getCommunitypostCommentList() {
		rm = new JSONObject();
		String cpId=getPara("cpId");
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		List<Object> paras = new ArrayList<Object>();
		StringBuffer where = new StringBuffer();
		where.append("where cpc.userInfoId=u.id and cpc.communityPostId=? and cpc.`status`=0 ");
		paras.add(cpId);
		/*
		 * if(S.notEmpty(week)){ where.append(" and week=?"); paras.add(week); }
		 */
		Page<Record> replyPage = Db.paginate(
				pageNumber,
				pageSize,
				"SELECT cpc.id,cpc.content,u.username,cpc.createDate  ",
				"FROM `communitypostcomment` cpc,userinfo u  "
						+ where.toString() + " order by " + sortField + " "
						+ sortOrder, paras.toArray());
		rm.put("data", replyPage.getList());
		rm.put("total", replyPage.getTotalRow());
		renderJson(rm);
	}
	public void getCommunitypostImgList() {
		rm = new JSONObject();
		String cpId=getPara("cpId");
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		List<Object> paras = new ArrayList<Object>();
		StringBuffer where = new StringBuffer();
		where.append("where cpi.communityPostId=? ");
		paras.add(cpId);
		/*
		 * if(S.notEmpty(week)){ where.append(" and week=?"); paras.add(week); }
		 */
		Page<Record> replyPage = Db.paginate(
				pageNumber,
				pageSize,
				"SELECT cpi.id,cpi.path,cpi.createDate ",
				"FROM `communitypostimg` cpi "
						+ where.toString() + " order by " + sortField + " "
						+ sortOrder, paras.toArray());
		rm.put("data", replyPage.getList());
		rm.put("total", replyPage.getTotalRow());
		renderJson(rm);
	}
}
