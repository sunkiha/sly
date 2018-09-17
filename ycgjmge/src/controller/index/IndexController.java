package controller.index;

import com.jfinal.plugin.activerecord.Record;
import comm.BaseController;

public class IndexController extends BaseController {
	public void index() {
		Record m = getUser();
		if (m == null) {
			login();
		} else {
			render("../admin.jsp");
		}

	}

	public void login() {
		render("../login.jsp");
	}
}
