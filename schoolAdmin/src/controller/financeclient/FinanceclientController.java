package controller.financeclient;

import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;

import comm.BaseController;
import comm.RecordBean;
import comm.S;

public class FinanceclientController extends BaseController {
	JSONObject rm;

	public void toReimDetail() {
		String id =getPara("id");
		Record rd=Db.findFirst("SELECT r.id,r.openDate,r.`status`,r.authFile,r.`desc`,r.createDate,r.reason,r.pday,m.uname FROM `reimburseme` r,manager m where r.managerId=m.id and r.id=?",id);
		setAttr("uc", rd);
		render("my_reimdetail.jsp");
	}
	public void reimUpdate() {
		String id =getPara("id");
		String pday =getPara("pday");
		String status =getPara("status");
		String reason =getPara("reason");
		if(!S.notEmpty(pday)) {
			pday="0";
		}
		if(!S.notEmpty(reason)) {
			reason="";
		}
		Db.update("update reimburseme set status=?,pday=?,reason=? where id=?",status,pday,reason,id);
		renderJson(getOk("修改成功"));
	}
}
