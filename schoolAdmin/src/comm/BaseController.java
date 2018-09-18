package comm;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.alibaba.fastjson.JSONObject;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;

/*@Before(ExceptionAndLogInterceptor.class)*/
public class BaseController extends Controller {
	protected JSONObject getOk(String msg) {
		JSONObject rm = new JSONObject();
		rm.put(S.code, 1);
		if ("".equals(msg) || null == msg) {
			rm.put(S.msg, "操作成功");
		} else {
			rm.put(S.msg, msg);
		}
		return rm;
	}
	protected JSONObject getError(String msg) {
		JSONObject rm = new JSONObject();
		rm.put(S.code, 0);
		if ("".equals(msg) || null == msg) {
			rm.put(S.msg, "操作失败");
		} else {
			rm.put(S.msg, msg);
		}
		return rm;
	}
	protected JSONObject getOk() {
		JSONObject rm = new JSONObject();
		rm.put(S.code, 1);
		rm.put(S.msg, "操作成功");
		return rm;
	}

	protected JSONObject getError() {
		JSONObject rm = new JSONObject();
		rm.put(S.code, 0);
		rm.put(S.msg, "操作失败");
		return rm;
	}

	public Record getUser() {
		Object user = getSession().getAttribute("user");
		if (user != null) {
			return (Record) user;
		} else {
			return null;
		}
	}

	public void setUser(Record m) {
		getSession().setAttribute("user", m);
	}

	public void exitUser() {
		removeSessionAttr("user");
	}

	/**
	 * 获取请求的 body
	 * 
	 * @param req
	 * @return
	 * @throws IOException
	 */
	public String getRequestBody() throws IOException {
		BufferedReader reader = getRequest().getReader();
		String input = null;
		StringBuffer requestBody = new StringBuffer();
		while ((input = reader.readLine()) != null) {
			requestBody.append(input);
		}
		return requestBody.toString();
	}

}
