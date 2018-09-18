package sys.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Before;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.plugin.activerecord.tx.Tx;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class SysController extends BaseController {
	public void getPowerPage() {
		JSONObject rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String name = getPara("name");
		StringBuffer where = new StringBuffer(" where ");
		where.append("status=0 ");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(name)) {
			where.append(" and name  like ?");
			paras.add("%" + name + "%");
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize, "select * ",
				"from role " + where.toString() + " order by " + sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void addModRole() {
		String json = getPara("data");
		JSONObject jo = JSONObject.parseObject(json);
		Object id = jo.get("id");
		if (!S.notEmpty(id)) {
			Record record = new RecordBean();
			jo.remove("id");
			record.setColumns(jo);
			Db.save("role", record);
		} else {
			Record record = new Record();
			record.setColumns(jo);
			Db.update("role", record);
		}
		renderJson(getOk());
	}

	public void getRoleById() {
		int id = getParaToInt("id");
		Record record = Db.findById("role", id);
		renderJson(record);
	}

	public void delRole() {
		int id = getParaToInt("id");
		Db.deleteById("role", id);
		renderJson(getOk());
	}

	public void getMenu() {
		Object roleId = getPara("roleId");
		List<Record> recordList = Db.find(
				"SELECT m.id,m.`name`,m.parentId,IF(ISNULL(p.id),FALSE,TRUE) checked FROM `menu` m LEFT JOIN power p on p.menuId=m.id and p.roleId=?  ORDER BY m.id",
				roleId);
		renderJson(recordList);
	}

	@Before(Tx.class)
	public void addModPower() {
		int roleId = getParaToInt("roleId");
		String ids = getPara("ids");
		List<Record> recordList = new ArrayList<Record>();

		Record powerRd = new Record();
		powerRd.set("roleId", roleId);
		Db.delete("power", "roleId", powerRd);
		if (S.notEmpty(ids)) {
			String[] idary = ids.split(",");
			for (String menuId : idary) {
				Record record = new RecordBean();
				record.set("menuId", menuId);
				record.set("roleId", roleId);
				recordList.add(record);
			}
			Db.batchSave("power", recordList, recordList.size());
		}
		renderJson(getOk());
	}

	public void getManagerPage() {
		JSONObject rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		String name = getPara("name");
		String status = getPara("status");
		StringBuffer where = new StringBuffer(" where 1=1");
		List<Object> paras = new ArrayList<Object>();
		if (S.notEmpty(name)) {
			where.append(" and m.username  like ?");
			paras.add("%" + name + "%");
		}
		if (S.notEmpty(status)) {
			where.append(" and m.status  = ?");
			paras.add(status);
		}
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"SELECT m.id,m.username,m.`status`,r.`name` roleName,m.createDate,m.modDate ,m.email ",
				"FROM `manager` m LEFT JOIN role r on r.id=m.roleId " + where.toString() + " order by " + sortField
						+ " " + sortOrder,
				paras.toArray());
		if ("ad".equals(getPara("os"))) {
			Map data=new HashMap<>();
			data.put("list", userInfoPage.getList());
			data.put("total", userInfoPage.getTotalRow());
			rm.put("data", data);
			rm.put(S.code, 1);
			rm.put(S.msg, "成功");
		} else {
			rm.put("data", userInfoPage.getList());
			rm.put("total", userInfoPage.getTotalRow());
			rm.put(S.code, 1);
			rm.put(S.msg, "成功");
		}
		renderJson(rm);
	}

	public void getRoleAll() {
		List<Record> list = Db.find("select id,name from role where status=0 order by createDate desc");
		renderJson(list);
	}

	public void addModManager() {
		String data = getPara("data");
		JSONObject jo = JSON.parseObject(data);
		String id = jo.getString("id");
		if (S.notEmpty(id)) {
			String username = jo.getString("username");
			Long c = Db.queryLong("select count(1) from manager where username=? and id=?", username, id);
			if (c < 1) {
				JSONObject rm = getError();
				rm.put(S.msg, "该帐号已存在");
				renderJson(rm);
			} else {
				Record record = new Record();
				record.setColumns(jo);
				Db.update("manager", record);
				renderJson(getOk());
			}
		} else {
			String username = jo.getString("username");
			Long c = Db.queryLong("select count(1) from manager where username=?", username);
			if (c > 0) {
				JSONObject rm = getError();
				rm.put(S.msg, "该帐号已存在");
				renderJson(rm);
			} else {
				Record record = new RecordBean();
				jo.remove("id");
				record.setColumns(jo);
				Db.save("manager", record);
				renderJson(getOk());
			}
		}
	}

	public void getManagerById() {
		int id = getParaToInt("id");
		Record record = Db.findById("manager", id);
		renderJson(record);
	}

	public void delManager() {
		int id = getParaToInt("id");
		Db.deleteById("manager", id);
		renderJson(getOk());
	}

	public void updateManager() {
		Record recordu = getUser();
		if (recordu != null) {
			int status = getParaToInt("status");
			int id = getParaToInt("id");
			Record record = new Record();
			record.set("id", id);
			record.set("status", status);
			Db.update("manager", record);
			renderJson(getOk());
		} else {
			JSONObject rm = getError();
			rm.put(S.msg, "无权限,请重新登录");
			renderJson(rm);
		}

	}
}
