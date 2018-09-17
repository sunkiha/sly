package controller.circle;

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

public class CircleController extends BaseController {
	JSONObject rm;

	//二级分类
	public void toCirlceList() {
		render("circle_list.jsp");
	}
	public void toAddCircle() {
		render("add_circle.jsp");
	}
	public void toModCircle() {
		String id=getPara("id");
		Record record=Db.findById("circle", id);
		setAttr("bean", record);
		render("mod_circle.jsp");
	}
//一级分类
	public void toCircleCategotyList() {
		render("circle_category_list.jsp");
	}
	public void toAddCircleCategory() {
		render("add_circle_category.jsp");
	}

	public void toModCircleCategory() {
		String id=getPara("id");
		Record record=Db.findById("circleCategory", id);
		setAttr("bean", record);
		render("mod_circle_category.jsp");
	}
	public void getCircleList() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String circleCategoryId = getPara("circleCategoryId");
		String name = getPara("name");
		StringBuffer where = new StringBuffer(" where c.STATUS = 0 and c.circleCategoryId=cc.id ");// c.status=0 and
		List<Object> paras = new ArrayList<Object>();
		if(S.notEmpty(circleCategoryId)){
			where.append(" and c.circleCategoryId  = ?");
			paras.add(circleCategoryId);
		}
		if(S.notEmpty(name)){
			where.append(" and c.name  like ?");
			paras.add("%" + name + "%");
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"	SELECT c.id,c.name,c.createDate,c.banner,cc.name circleCategoryName ", " FROM circle c,circlecategory cc " + where.toString()
						+ " order by " + sortField + " " + sortOrder,
				paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
	public void getCircleCategoryList() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String name=getPara("name");
		StringBuffer where = new StringBuffer(" where 1=1");// c.status=0 and
		List<Object> paras = new ArrayList<Object>();
		if(S.notEmpty(name)){
			where.append(" and name  like ?");
			paras.add("%" + name + "%");
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"SELECT * ", " FROM `circleCategory`" + where.toString()
				+ " order by " + sortField + " " + sortOrder,
				paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void addCircleCategory() {
		String name = getPara("name");
		Record record = new RecordBean();
		record.set("name", name);
		Db.save("circleCategory", record);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}
	public void modCircleCategory() {
		String name = getPara("name");
		String id = getPara("id");
		Record record = new RecordBean();
		record.set("name", name);
		record.set("id", id);
		Db.update("circleCategory", record);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}
	public void delCircleCategory(){
		String id=getPara("id");
		Db.deleteById("circleCategory", id);
		renderText("删除成功");
	}
	public void getCircleCategoryAll(){
		List<Record> li=Db.find("select id,name from circleCategory order by createDate desc");
		renderJson(li);
	}
	public void getCircleListByCategoryId(){
		String circleCategoryId=getPara("circleCategoryId");
		List<Record> li=Db.find("select id,name from circle where circleCategoryId=?",circleCategoryId);
		renderJson(li);
	}
	public void addCircle() {
		UploadFile uFile = getFile("banner");
		String name = getPara("name");
		String circleCategoryId = getPara("circleCategoryId");
		String banner = S.oid();
		Record record = new RecordBean();
		record.set("id", banner);
		record.set("name", name);
		record.set("circleCategoryId", circleCategoryId);
		record.set("banner", banner);
		if (uFile != null) {
			File file = new File("F:/yunyu/" + banner + ".png");
			uFile.getFile().renameTo(file);
		}
		Db.save("circle", record);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}
	public void modCircle() {
		UploadFile uFile = getFile("banner");
		String id = getPara("id");
		String name = getPara("name");
		String banner = getPara("banner1");
		String circleCategoryId = getPara("circleCategoryId");
		Record record = new RecordBean();
		record.set("id", id);
		record.set("name", name);
		record.set("circleCategoryId", circleCategoryId);
		if (uFile != null) {
			File file = new File("F:/yunyu/" + banner + ".png");
			uFile.getFile().renameTo(file);
		}
		Db.update("circle", record);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}
	public void delCircle(){
		String id=getPara("id");
		String img=getPara("banner");
		Db.deleteById("circle", id);
		File file=new File("F:/yunyu/" + img + ".png");
		if(file.exists()){
			file.delete();
		}
		renderText("删除成功");
	}
}
