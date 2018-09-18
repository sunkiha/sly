package menu.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.kit.JsonKit;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class MenuController extends BaseController {
	public void getMenuParentPage() {
		JSONObject rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String name = getPara("name");
		System.out.println(name);
		StringBuffer where = new StringBuffer(" where ");
		where.append("parentId=0 ");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(name)) {
			where.append(" and name  like ?");
			paras.add("%" + name + "%");
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"select * ", "from menu " + where.toString() + " order by "
						+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void getMenuPage() {
		JSONObject rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String parentId = getPara("parentId");
		String name = getPara("name");
		StringBuffer where = new StringBuffer(" where status=0");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(parentId)) {
			where.append(" and parentId=? ");
			paras.add(parentId);
		}
		if (S.notEmpty(name)) {
			where.append(" and name  like ?");
			paras.add("%" + name + "%");
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"select * ", "from menu " + where.toString() + " order by "
						+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void addOrModMenu() {
		String data = getPara("data");
		JSONObject jo = JSON.parseObject(data);
		String id = jo.getString("id");
		String name = jo.getString("name");
		String url = jo.getString("url");
		int parentId = jo.getIntValue("parentId");
		Record record = new Record();
		record.set("name", name);
		record.set("parentId", parentId);
		if (S.notEmpty(url)) {
			record.set("url", url);
		}
		if (S.notEmpty(id)) {
			record.set("id", id);
			Db.update("menu", record);
		} else {
			record.set("createDate", new Date());
			Db.save("menu", record);
		}
		renderJson(getOk());
	}

	public void getMenuById() {
		int id = getParaToInt("id");
		Record record = Db.findById("menu", id);
		renderJson(record);
	}

	public void delMenu() {
		JSONObject rm = getOk();
		String id = getPara("id");
		int parentId = getParaToInt("parentId");
		if (parentId == 0) {
			Long count = Db.queryLong(
					"select count(1) from menu where parentId=?", id);
			if (count != 0) {
				rm.put(S.code, 1);
				rm.put(S.msg, "该父类有子菜单不能删除");
			} else {
				Db.deleteById("menu", id);
			}
		} else {
			Db.deleteById("menu", id);
		}
		renderJson(rm);
	}
	public void getMenuPower() {
		int id=getUser().getInt("id");
		List<Record> recordList = Db
				.find("SELECT mn.id,mn.`name`,mn.parentId,mn.url FROM manager m,power p,menu mn where p.roleId=m.roleId and mn.id=p.menuId and m.id=?",
						id);
		/*List<Record> recordList = Db
				.find("SELECT mn.id,mn.`name`,mn.parentId,mn.url FROM menu mn ");*/
		renderJson(recordList);
	}
}
