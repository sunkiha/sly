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

public class NewsController extends BaseController {
	JSONObject rm;

	public void toAddHomeNews() {
		String newsId = getPara("newsId");
		setAttr("newsId", newsId);
		render("addHomeNews.jsp");
	}

	public void toHomeNewsList() {
		render("homeNewsList.jsp");
	}

	public void toModNews() {
		String newsId = getPara("newsId");
		setAttr("newsId", newsId);
		render("news_mod.jsp");
	}

	public void toAddNews() {
		render("news_add.jsp");
	}

	public void toAddNewsCategory() {
		render("news_category_add.jsp");
	}

	public void toModNewsCategory() {
		render("news_category_mod.jsp");
	}

	public void toNewsCategoryList() {
		render("news_category_list.jsp");
	}

	public void toNewsList() {
		render("news_list.jsp");
	}
	public void toNewsComment() {
		render("news_comment_list.jsp");
	}
	public void addHomeNews() {
		UploadFile uFile = getFile("banner");
		Record record = new RecordBean();
		String newsId = getPara("newsId");
		int newsCategoryType = Db
				.queryInt(
						"SELECT nc.type FROM newscategory nc,news n where nc.id=n.newscategoryId and n.id=?",
						newsId);
		int bannerMax = Db.queryInt("SELECT MAX(pic) pic FROM `homenews`") + 1;
		record.set("pic", bannerMax);
		record.set("type", newsCategoryType);
		record.set("newsId", newsId);
		record.set("createDate", new Date());
		Db.save("homenews", record);
		// String banner = S.oid();
		if (uFile != null) {
			File file = new File("F:/yunyu/" + bannerMax + ".png");
			uFile.getFile().renameTo(file);
		}
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}

	public void modNews() {
		UploadFile uFile = getFile("bannerTmp");
		if (uFile != null) {
			String banner = getPara("picture");
			if (!S.notEmpty(banner)) {
				setAttr("msg", "数据异常");
				render("../msg.jsp");
			} else {
				File file = new File("F:/yunyu/" + banner + ".png");
				if (file.exists()) {
					file.delete();
				}
				uFile.getFile().renameTo(file);
			}

		}
		String id = getPara("id");
		String title = getPara("title");
		String summary = getPara("summary");
		String content = getPara("content");
		String newscategoryId = getPara("newscategoryId");
		Record record = new RecordBean();
		record.set("id", id);
		record.set("title", title);
		record.set("summary", summary);
		record.set("content", content);
		record.set("newscategoryId", newscategoryId);
		Db.update("news", record);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}

	public void delHomeNews() {
		String id = getPara("id");
		String path = getPara("banner");
		Db.deleteById("homenews", id);
		File file = new File("F:/yunyu/" + path + ".png");
		file.delete();
		renderText("删除成功");
	}

	public void pushNews() throws Exception {
		String id = getPara("id");
		Record news = Db.findById("news", id);
		String title = news.getStr("title");
		String summary = news.getStr("summary");
		Map<String, String> extras = new HashMap<String, String>();
		extras.put("type", S.pushNews);
		extras.put("newsId", id);
		extras.put("createDate", news.getTimestamp("createDate")
				.toLocaleString());
		PushPayload payload = PushPayload
				.newBuilder()
				.setPlatform(Platform.all())
				.setAudience(Audience.tag("on"))
				.setNotification(
						Notification
								.newBuilder()
								.setAlert(summary)
								.addPlatformNotification(
										AndroidNotification.newBuilder()
												.setTitle(title)
												.addExtras(extras).build())
								.addPlatformNotification(
										IosNotification.newBuilder()
												.incrBadge(1).addExtras(extras)
												.build()).build()).build();
		S.getJPushClient().sendPush(payload);
		renderJson();
	}

	public void getNewscategorys() {
		List<Record> newsCategory = Db
				.find("SELECT * FROM `newscategory` order by id ");
		renderJson(newsCategory);
	}

	public void getNewsById() {
		String newsId = getPara("newsId");
		Record news = Db.findById("news", newsId);
		renderJson(news);
	}

	public void addNews() {
		UploadFile uFile = getFile("banner");
		if (uFile == null) {
			setAttr("msg", "banner图片不能为空");
			render("../msg_back.jsp");
		} else {
			String id = S.oid();
			String picture = id;
			File file = new File("F:/yunyu/" + picture + ".png");
			uFile.getFile().renameTo(file);
			String title = getPara("title");
			String summary = getPara("summary");
			String content = getPara("content");
			String newscategoryId = getPara("newscategoryId");
			Record record = new RecordBean();
			record.set("id", id);
			record.set("title", title);
			record.set("summary", summary);
			record.set("content", content);
			record.set("newscategoryId", newscategoryId);
			record.set("picture", picture);
			Db.save("news", record);
			setAttr("msg", "添加成功");
			render("../msg_back.jsp");
		}
	}

	// json----------------
	public void getHomeNewsList() {
		String type = getPara("type");
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		List<Object> paras = new ArrayList<Object>();
		StringBuffer where = new StringBuffer(" where ");
		where.append("hn.newsId = n.id ");
		// paras.add(id);

		if (S.notEmpty(type)) {
			where.append("AND hn.type = ?");
			paras.add(type);
		}

		Page<Record> replyPage = Db.paginate(pageNumber, pageSize,
				"SELECT hn.id,hn.newsId,n.title,hn.pic,hn.createDate ",
				"FROM `homenews` hn,news n " + where.toString() + " order by "
						+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", replyPage.getList());
		rm.put("total", replyPage.getTotalRow());
		renderJson(rm);
	}

	// json----------------
	public void getNewsCategoryList() {
		String type = getPara("type");
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		List<Object> paras = new ArrayList<Object>();
		StringBuffer where = new StringBuffer(" where ");
		where.append("1=1 ");
		if (S.notEmpty(type)) {
			where.append(" AND type=?");
			paras.add(type);
		}
		Page<Record> page = Db.paginate(pageNumber, pageSize, "SELECT *  ",
				"FROM `newscategory` " + where.toString() + " order by "
						+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", page.getList());
		rm.put("total", page.getTotalRow());
		renderJson(rm);
	}

	public void addNewsCategory() {
		String name = getPara("name");
		String type = getPara("type");
		Record record = new Record();
		record.set("name", name);
		record.set("type", type);
		Db.save("newsCategory", record);
		rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "添加成功");
		renderJson(rm);
	}

	public void modNewsCategory() {
		String id = getPara("id");
		String name = getPara("name");
		String type = getPara("type");
		Record record = new Record();
		record.set("id", id);
		record.set("name", name);
		record.set("type", type);
		Db.update("newsCategory", record);
		rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "添加成功");
		renderJson(rm);
	}

	public void delNewsCategory() {
		String id = getPara("id");
		Db.deleteById("newsCategory", id);
		rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "添加成功");
		renderJson(rm);
	}

	public void getNewsCategoryById() {
		String id = getPara("id");
		Record record = Db.findById("newsCategory", id);
		renderJson(record);
	}
	public void getNewsCond(){
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String title = getPara("title");
		String type = getPara("type");
		String category = getPara("category");
		StringBuffer where = new StringBuffer(" where ");
		where.append(" n.status=0 ");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(type)) {
			where.append(" and c.type = ?");
			paras.add(type);
		}
		if (S.notEmpty(category)) {
			where.append(" and n.newscategoryid= ?");
			paras.add(category);
		}
		if(S.notEmpty(title)){
			where.append(" and n.title like ? ");
			paras.add("%"+title+"%");
		}
		Page<Record> userInfoPage = Db
				.paginate(
						pageNumber,
						pageSize,
						"select n.id,n.ispush,n.title,n.createDate,c.name,(select count(*) from homenews as h where h.newsId=n.id) as homenews,(select count(*) from newscomment as c where c.newsId=n.id) as countComment",
						"from news as n  join newscategory as c on c.id=n.newscategoryId" + where.toString() + " order by "
								+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	
	public void getNewsCategory(){
		String type=getPara("type");
		System.out.println(type);
		List<Record> ncList=null;
		if("".equals(type)){
			ncList=Db.find("select id,name from newscategory");
		}else{
			ncList=Db.find("select id,name from newscategory where type="+type);
		}
		
		renderJson(ncList);
	}
	public void deleteNews(){
		String id=getPara("id");
		Db.deleteById("news", id);
		renderText("删除成功");
	}
	public void getNewsCommentByNewsId(){
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String title = getPara("title");
		String type = getPara("type");
		String category = getPara("category");
		String newsId = getPara("newsId");
		System.out.println(newsId);
		StringBuffer where = new StringBuffer(" where c.status=0 and c.newsId=?");
		List<Object> paras = new ArrayList<Object>();
		paras.add(newsId);
		if (S.notEmpty(type)) {
			where.append(" and c.type = ?");
			paras.add(type);
		}
		if (S.notEmpty(category)) {
			where.append(" and n.newscategoryid= ?");
			paras.add(category);
		}
		if(S.notEmpty(title)){
			where.append(" and n.title like ? ");
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
	
}
