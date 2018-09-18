package comm;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.util.Locale;
import java.util.ResourceBundle;
import java.util.UUID;

public class S {
	public final static String baseImg = "http://60.174.233.153:8080/src/";
	public final static String baseVideo = "http://60.174.233.153:8080/src/";
	public final static int PAGESIZE = 8; // 分页每页记录数
	public final static int android = 0;
	public final static int ios = 1;
	// 状态字段
	public final static String status = "status";
	public final static String msg = "msg";
	public final static String code = "code";

	// 文件保存路径
	public final static String uploadPath = "d://servofile/";
	// 极光推送key
	public final static String appKey = "36c3642dd7eaede61bacba62";
	public final static String masterSecret = "3f288cc75b59d8a0e48598e6";

	public static String getFileUrl(String file) {
		return "http://localhost:8080/schoolAdmin/upload/" + file;
	}

	public static String uuid() {
		return UUID.randomUUID().toString().replace("-", "");
	}

	public static String oid() {
		return ObjectId.oid();
	}

	public final static String MD5(String s) {
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'A', 'B', 'C', 'D', 'E', 'F' };
		try {
			byte[] btInput = s.getBytes();
			// 获得MD5摘要算法的 MessageDigest 对象
			MessageDigest mdInst = MessageDigest.getInstance("MD5");
			// 使用指定的字节更新摘要
			mdInst.update(btInput);
			// 获得密文
			byte[] md = mdInst.digest();
			// 把密文转换成十六进制的字符串形式
			int j = md.length;
			char str[] = new char[j * 2];
			int k = 0;
			for (int i = 0; i < j; i++) {
				byte byte0 = md[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			return new String(str);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
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
}
