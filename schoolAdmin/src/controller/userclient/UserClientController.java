package controller.userclient;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class UserClientController extends BaseController {
	JSONObject rm;

	public void getNewsCond() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String title = getPara("title");
		String type = getPara("type");
		StringBuffer where = new StringBuffer(" where ");
		where.append(" status=0 ");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(type)) {
			where.append(" and type = ?");
			paras.add(type);
		}
		if (S.notEmpty(title)) {
			where.append(" and title like ? ");
			paras.add("%" + title + "%");
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize, "SELECT * ",
				" FROM `news` " + where.toString() + " order by " + sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	// 我的报销
	public void getMyReim() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String status = getPara("status");
		Record r = getUser();
		if (r == null) {
			renderJson(getError("登录失效"));
		} else {
			StringBuffer where = new StringBuffer(" where ");
			where.append(" 1=1");
			List<Object> paras = new ArrayList<Object>();

			if (S.notEmpty(status)) {
				where.append(" and status = ?");
				paras.add(status);
			}

			where.append(" and managerid= ? ");
			paras.add(r.getInt("id"));

			Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize, "SELECT * ",
					" FROM `reimburseme` " + where.toString() + " order by " + sortField + " " + sortOrder,
					paras.toArray());
			if ("ad".equals(getPara("os"))) {
				Map data = new HashMap<>();
				data.put("list", userInfoPage.getList());
				data.put("total", userInfoPage.getTotalRow());
				rm.put("data", data);

			} else {
				rm.put("data", userInfoPage.getList());
				rm.put("total", userInfoPage.getTotalRow());
			}
			rm.put(S.code, 1);
			rm.put(S.msg, "成功");
			renderJson(rm);
		}
	}

	public void getReim() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String status = getPara("status");

		StringBuffer where = new StringBuffer(" where ");
		where.append(" 1=1");
		List<Object> paras = new ArrayList<Object>();

		if (S.notEmpty(status)) {
			where.append(" and status = ?");
			paras.add(status);
		}
		/*
		 * if (S.notEmpty(title)) { where.append(" and title like ? "); paras.add("%" +
		 * title + "%"); }
		 */

		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize, "SELECT * ",
				" FROM `reimburseme` " + where.toString() + " order by " + sortField + " " + sortOrder,
				paras.toArray());
		if ("ad".equals(getPara("os"))) {
			Map data = new HashMap<>();
			data.put("list", userInfoPage.getList());
			data.put("total", userInfoPage.getTotalRow());
			rm.put("data", data);
			rm.put(S.code, 1);
			rm.put(S.msg, "成功");
		} else {
			rm.put("data", userInfoPage.getList());
			rm.put("total", userInfoPage.getTotalRow());
		}
		renderJson(rm);
	}

	////
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

	public void getNewsById() {
		String newsId = getPara("newsId");
		Record news = Db.findById("news", newsId);
		renderJson(news);
	}

	public void addNews() {
		String title = getPara("title");
		String author = getUser().getStr("username");
		String content = getPara("content");
		String type = getPara("type");
		Record record = new RecordBean();
		record.set("title", title);
		record.set("author", author);
		record.set("content", content);
		record.set("type", type);
		Db.save("news", record);
		setAttr("msg", "添加成功");
		render("../msg_back.jsp");
		/*
		 * UploadFile uFile = getFile("banner"); if (uFile == null) { setAttr("msg",
		 * "banner图片不能为空"); render("../msg_back.jsp"); } else { String id = S.oid();
		 * String picture = id; File file = new File("F:/yunyu/" + picture + ".png");
		 * uFile.getFile().renameTo(file); String title = getPara("title"); String
		 * summary = getPara("summary"); String content = getPara("content"); String
		 * newscategoryId = getPara("newscategoryId"); Record record = new RecordBean();
		 * record.set("id", id); record.set("title", title); record.set("summary",
		 * summary); record.set("content", content); record.set("newscategoryId",
		 * newscategoryId); record.set("picture", picture); Db.save("news", record);
		 * setAttr("msg", "添加成功"); render("../msg_back.jsp"); }
		 */
	}

	public void deleteNews() {
		String id = getPara("id");
		Db.deleteById("news", id);
		renderText("删除成功");
	}

	// 添加报销
	public void addReim() {
		if (getUser() == null) {
			renderJson(getError("登录失效,请重新登录"));
		} else {
			UploadFile upload = getFile();
			String fileName = upload.getFileName();
			String format = fileName.substring(fileName.lastIndexOf("."));
			String imgUrl = S.oid() + format;
			String openDate = getPara("openDate");
			String desc = getPara("desc");
			String money = getPara("money");
			Record record = new RecordBean();
			record.set("authFile", S.getFileUrl(imgUrl));
			record.set("desc", desc);
			record.set("openDate", openDate);
			record.set("money", money);
			record.set("managerId", getUser().getInt("id"));
			record.set("status", "0");
			Db.save("reimburseme", record);
			File file = new File(upload.getUploadPath() + "\\" + imgUrl);
			upload.getFile().renameTo(file);
			renderJson(getOk());
		}
	}

	public void toReimDetail() {
		String id = getPara("id");
		Record rd = Db.findFirst(
				"SELECT r.id,r.openDate,r.`status`,r.authFile,r.`desc`,r.createDate,r.reason,r.pday,m.uname FROM `reimburseme` r,manager m where r.managerId=m.id and r.id=?",
				id);
		setAttr("uc", rd);
		render("../userclient/my_reimdetail.jsp");
	}

	public void getReimDetail() {
		String id = getPara("id");
		Record rd = Db.findFirst(
				"SELECT r.id,r.openDate,r.`status`,r.authFile,r.`desc`,r.createDate,r.reason,r.pday,m.uname FROM `reimburseme` r,manager m where r.managerId=m.id and r.id=?",
				id);
		rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "成功");
		rm.put("data", rd);
		renderJson(rm);
	}
}
