package comm;

import java.io.UnsupportedEncodingException;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.UUID;

import cn.jpush.api.JPushClient;

public class S {
	
	public final static String pushNews ="0"; //新闻类型推送
	public final static String inspectReport ="1"; //报告单
	public final static int PAGESIZE = 8; // 分页每页记录数

	// 状态字段
	public final static String status = "status";
	public final static String msg = "msg";
	public final static String code = "code";

	// 用户类型
	public final static String userOrdinary = "0";// 大众
	public final static String doctor = "1";// 医生
	//文件保存路径
	public final static String uploadPath="F://yunyu/";
	// 极光推送key
	public final static String appKey = "eacdba668e3b7ddd8cf353bc";
	public final static String masterSecret = "5f0465646e2e2b648b58a2d8";

	// 极光医生版本聊天推送key
	public final static String docappKey = "cfe170efcd6030aae04013a6";
	public final static String docmasterSecret = "3e80cd2669699f883a3bfc8b";

	public static String uuid() {
		return UUID.randomUUID().toString().replace("-", "");
	}
	public static String oid() {
	     return ObjectId.oid();
	}
	public static void a() {

		throw new UserNoLoginException();
	}

	public static String getChinese(String str, String encoding) {
		if (encoding == null || encoding.trim() == "") {
			encoding = "UTF-8";
		}
		try {
			str = new String(str.getBytes("iso-8859-1"), encoding);
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		return str;
	}

	public ResourceBundle getProperties(String fileName) {
		Locale zhLoc = new Locale("zh", "CN"); // 表示中国地区
		// 找到属性文件
		ResourceBundle zhrb = ResourceBundle.getBundle(fileName, zhLoc);
		return zhrb;
	}
	public static boolean notEmpty(Object obj) {
		if (obj == null || "".equals(obj)) {
			return false;
		}
		return true;
	}
	public static JPushClient getJPushClient(){
		return new JPushClient(masterSecret, appKey);
	}
}
