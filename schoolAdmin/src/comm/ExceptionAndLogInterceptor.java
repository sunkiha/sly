package comm;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

public class ExceptionAndLogInterceptor implements Interceptor {

	@Override
	public void intercept(Invocation ai) {
	/*	try {
			ai.invoke();
		} catch (Exception e) {
			System.out.println(e.toString());
			JSONObject rm=new JSONObject();
			if("用户未登录".equals(e.getMessage())){
				rm.put(S.code, 1);
				rm.put(S.msg, "用户未登录");
			}else{
				rm.put(S.code, 1);
				rm.put(S.msg, "服务器异常");
			}
			ai.getController().renderJson(rm);
		}*/
	}

}
