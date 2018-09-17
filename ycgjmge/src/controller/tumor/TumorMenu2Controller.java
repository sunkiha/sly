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

public class TumorMenu2Controller extends BaseController {
	JSONObject rm;

	public void index() {
		String tumorId = getPara("tumorId");
		setAttr("tumorId", tumorId);
		render("index.jsp");
	}

	public void toAdd() {
		String tumorId = getPara("tumorId");
		setAttr("tumorId", tumorId);
		render("add.jsp");
	}

	public void toMod() {
		/*
		 * String homeMenuId=getPara("homeMenuId"); setAttr("homeMenuId",
		 * homeMenuId);
		 */
		render("mod.jsp");
	}

	public void toTumorPage() {
		render("tumorPage.jsp");
	}

	public void add() {
		UploadFile uFile = getFile("banner");
		String banner;
		Record equipment = new RecordBean();
		if (uFile != null) {
			banner = S.oid();
			equipment.set("banner", banner);
			File file = new File("F:/yunyu/zhongliu/" + banner + ".png");
			uFile.getFile().renameTo(file);
		}
		String tumorMenuId = getPara("tumorMenuId");
		String tumorId = getPara("tumorId");
		String summary = getPara("summary");
		String title = getPara("title");
		String content = getPara("content");
		equipment.set("title", title);
		equipment.set("content", content);
		equipment.set("summary", summary);
		equipment.set("tumorMenuId", tumorMenuId);
		equipment.set("tumorId", tumorId);
		Db.save("tumor_menu_content", equipment);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}

	public void mod() {
		UploadFile uFile = getFile("bannertmp");
		String id = getPara("id");
		String title = getPara("title");
		String banner = getPara("banner");
		String content = getPara("content");
		String summary = getPara("summary");
		String tumorMenuId = getPara("tumorMenuId");
		Record equipment = new RecordBean();
		if (uFile != null) {
			File file = new File("F:/yunyu/zhongliu/" + banner + ".png");
			if (file.exists()) {
				file.delete();
			}
			uFile.getFile().renameTo(file);
		}
		equipment.set("id", id);
		equipment.set("title", title);
		equipment.set("content", content);
		equipment.set("summary", summary);
		equipment.set("tumorMenuId", tumorMenuId);
		Db.update("tumor_menu_content", equipment);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}

	public void deleteById() {
		String id = getPara("id");
		Db.update("update tumor_menu_content set status=1 where id=?", id);
		renderText("删除成功");
	}

	public void getTumorMenuContentPage() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String title = getPara("title");
		String tumorId = getPara("tumorId");
		String tumorMenuId = getPara("tumorMenuId");
		StringBuffer where = new StringBuffer(" where ");
		where.append("tmc.status=0 and tmc.tumorMenuId = tm.id and tmc.tumorId=t.id");
		List<Object> paras = new ArrayList<Object>();
		where.append(" and tmc.tumorId=? ");
		paras.add(tumorId);
		if (S.notEmpty(title)) {
			where.append(" and tmc.title  like '%"+title+"%'");
		}
		if(S.notEmpty(tumorMenuId)){
			where.append(" and tmc.tumorMenuId=? ");
			paras.add(tumorMenuId);
		}
		Page<Record> userInfoPage = Db
				.paginate(
						pageNumber,
						pageSize,
						"SELECT tmc.id,t.name tumorName,tmc.summary,tmc.banner,tmc.content,tmc.createDate,tmc.modDate,tmc.title,tm.`name` tumorMenuName,tm.id tumorMenuId ",
						" from tumor_menu_content tmc,tumor_menu tm,tumor t" + where.toString()
								+ " order by tmc." + sortField + " " + sortOrder,
						paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void getTumorMenuContentById() {
		String id = getPara("id");
		Record record = Db.findById("tumor_menu_content", id);
		renderJson(record);
	}
	public void getTumorMenu(){
		List<Record> list=Db.find("SELECT * FROM `tumor_menu` where status=0");
		renderJson(list);
	}
}
