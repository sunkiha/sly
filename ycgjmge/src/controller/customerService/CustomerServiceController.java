package controller.customerService;

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

public class CustomerServiceController extends BaseController {
	JSONObject rm;

	public void toCustomerServiceList() {
		render("customer_service_list.jsp");
	}

	public void toAddCustomerService() {
		render("add_customer_service.jsp");
	}

	public void toModCustomerService() {
		String id=getPara("id");
		Record record=Db.findFirst("select * from customerService where id=?",id);
		setAttr("bean",record);
		render("mod_customer_service.jsp");
	}
	public void getCustomerServiceList() {
		rm = new JSONObject();
		int pageNumber = getParaToInt("pageIndex", 0) + 1;
		int pageSize = getParaToInt("pageSize");
		String sortField = getPara("sortField");
		String sortOrder = getPara("sortOrder");
		StringBuffer where = new StringBuffer(" where 1=1");// c.status=0 and
		List<Object> paras = new ArrayList<Object>();
		Page<Record> userInfoPage = Db.paginate(pageNumber, pageSize,
				"SELECT * ", " FROM `customerService`" + where.toString()
						+ " order by " + sortField + " " + sortOrder,
				paras.toArray());
		rm.put("data", userInfoPage.getList());
		rm.put("total", userInfoPage.getTotalRow());
		renderJson(rm);
	}

	public void addCustomerService() {
		UploadFile uFile = getFile("img");
		String nickname = getPara("nickname");
		String qq = getPara("qq");
		String img = S.oid();
		Record record = new RecordBean();
		record.set("nickname", nickname);
		record.set("qq", qq);
		record.set("img", img);
		if (uFile != null) {
			File file = new File("F:/yunyu/" + img + ".png");
			uFile.getFile().renameTo(file);
		}
		Db.save("customerService", record);
		setAttr("msg", "添加成功");
		render("../msg.jsp");
	}
	public void modCustomerService() {
		UploadFile uFile = getFile("img");
		String nickname = getPara("nickname");
		String qq = getPara("qq");
		String id = getPara("id");
		String img = S.oid();
		Record record = new RecordBean();
		record.set("nickname", nickname);
		record.set("qq", qq);
		record.set("id", id);
		if (uFile != null) {
			File file = new File("F:/yunyu/" + img + ".png");
			uFile.getFile().renameTo(file);
		}
		Db.update("customerService", record);
		setAttr("msg", "修改成功");
		render("../msg.jsp");
	}
	public void deleteCustomerService(){
		String id=getPara("id");
		String img=getPara("img");
		Db.deleteById("customerService", id);
		File file=new File("F:/yunyu/" + img + ".png");
		if(file.exists()){
			file.delete();
		}
		renderText("删除成功");
	}
}
