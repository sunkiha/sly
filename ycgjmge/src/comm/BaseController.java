package comm;

import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Record;

public class BaseController extends Controller{
	public Record getUser(){
		Object user=getSession().getAttribute("user");
		if(user!=null){
			return (Record)user;
		}else{
			return null;
		}
	}
	public void setUser(Record m){
		//getSession().setAttribute("userInfo",m);
		getSession().setAttribute("user",m);
	}
	public void exitUser(){
		removeSessionAttr("user");
	}
}
