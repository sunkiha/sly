package controller.circle;

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

public class TopicsController extends BaseController {
	JSONObject rm;

	public void toTopicsList() {
		render("topics_list.jsp");
	}

	public void getTopics() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String circleCategoryId = getPara("circleCategoryId");
		String circleId = getPara("circleId");
		String title = getPara("title");
		StringBuffer where = new StringBuffer(" where t.status=0 ");// c.status=0
																	// and
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(circleCategoryId)) {
			where.append(" and c.circleCategoryId  = ?");
			paras.add(circleCategoryId);
		}
		if (S.notEmpty(circleId)) {
			where.append(" and c.id  = ?");
			paras.add(circleId);
		}
		if (S.notEmpty(title)) {
			where.append(" and t.title  like ?");
			paras.add("%" + title + "%");
		}
		Page<Record> userInfoPage = Db
				.paginate(
						pageNumber,
						pageSize,
						"SELECT t.id,t.title,t.content,t.createDate,u.username,u.nickname,c. name circleName, cc.name circleCategoryName ",
						" FROM topics t LEFT JOIN userInfo u ON u.id = t.userInfoId LEFT JOIN circle c ON c.id = t.circleId  LEFT JOIN circleCategory cc ON cc.id = c.circleCategoryId "
								+ where.toString()
								+ " order by "
								+ sortField
								+ " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void addTopics() {
		String id=getPara("id");
		if(S.notEmpty(id)){
			Record record=new Record();
			record.set("id", id);
			record.set("title", getPara("title"));
			record.set("content", getPara("content"));
			record.set("circleId", getPara("circleId"));
			record.set("modDate", new Date());
			Db.update("topics",record);
		}else{
			Record record = new RecordBean();
			record.set("id", S.oid());
			record.set("title", getPara("title"));
			record.set("content", getPara("content"));
			record.set("circleId", getPara("circleId"));
			record.set("userInfoId", 0);
			Db.save("topics", record);
			renderText("添加成功");
		}
		
	}

	public void getTopicsById() {
		String id = getPara("id");
		Record record = Db
				.findFirst("select t.id,t.content,t.title,t.circleId,c.circleCategoryId from topics t,circleCategory cc,circle c where c.circleCategoryId=cc.id and c.id=t.circleId and t.id=?",
						id);
		renderJson(record);
	}

	public void delTopics() {
		String id = getPara("id");
		Db.deleteById("topics", id);
		renderText("删除成功");
	}

}
