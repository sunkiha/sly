package controller.news;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.jpush.api.JPushClient;
import cn.jpush.api.common.resp.APIConnectionException;
import cn.jpush.api.common.resp.APIRequestException;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.AndroidNotification;
import cn.jpush.api.push.model.notification.IosNotification;
import cn.jpush.api.push.model.notification.Notification;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class NewsCommentController extends BaseController {
	JSONObject rm;
public void toNewsComment(){
	
	render("news_comment_list2.jsp");
}
	
	public void getNewsCommentByNewsId(){
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String title = getPara("title");
		String status = getPara("status");
		String category = getPara("category");
		String newsId = getPara("newsId");
		StringBuffer where = new StringBuffer(" where 1=1");//c.status=0 and 
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(newsId)) {
			where.append(" and  c.newsId=?");
			paras.add(newsId);
		}
		if (S.notEmpty(status)) {
			where.append(" and c.status = ?");
			paras.add(status);
		}
		if (S.notEmpty(category)) {
			where.append(" and n.newscategoryid= ?");
			paras.add(category);
		}
		if(S.notEmpty(title)){
			where.append(" and c.content like ? ");
			paras.add("%"+title+"%");
		}
		Page<Record> userInfoPage = Db
				.paginate(
						pageNumber,
						pageSize,
						"select c.id,c.head,c.nickname,c.content,c.status,c.createDate,n.title",
						" from newscomment as c join news as n on n.id=c.newsId " + where.toString() + " order by "
								+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	public void getNewsComment(){
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String title = getPara("title");
		String status = getPara("status");
		String category = getPara("category");
		String newsId = getPara("newsId");
		StringBuffer where = new StringBuffer(" where 1=1");//c.status=0 and 
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(newsId)) {
			where.append(" and  c.newsId=?");
			paras.add(newsId);
		}
		if (S.notEmpty(status)) {
			where.append(" and c.status = ?");
			paras.add(status);
		}
		if (S.notEmpty(category)) {
			where.append(" and n.newscategoryid= ?");
			paras.add(category);
		}
		if(S.notEmpty(title)){
			where.append(" and c.content like ? ");
			paras.add("%"+title+"%");
		}
		Page<Record> userInfoPage = Db
				.paginate(
						pageNumber,
						pageSize,
						"select c.id,c.head,c.nickname,c.content,c.status,c.createDate,n.title",
						" from newscomment as c join news as n on n.id=c.newsId" + where.toString() + " order by "
								+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	//评论通过
	public void checkCommentPass(){
		String id=getPara("id");
		Db.update("update newscomment  set status=1 where id=?",id);
		renderText("审核成功");
	}
}
