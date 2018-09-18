package role.controller;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import comm.BaseController;
import comm.S;

public class RoleController extends BaseController {
	public void getRolePage() {
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
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"select * ", "from role " + where.toString() + " order by "
						+ sortField + " " + sortOrder, paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}
}
