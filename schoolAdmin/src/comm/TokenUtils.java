package comm;

import com.google.common.base.Charsets;
import com.google.common.hash.Hashing;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Charles
 */
public class TokenUtils {

	private static final String privateKey = "fdas34ljfr好sja@#8$%dfkl;js&4*daklfjsdl;akfjsa342";

	public static String getToken(String pubKey, String date) {
		return Hashing.md5().newHasher().putString(pubKey, Charsets.UTF_8)
				.putString(privateKey, Charsets.UTF_8)
				.putString(date, Charsets.UTF_8).hash().toString();
	}

	public static String getToken(String pubKey, Date date) {
		return Hashing.md5().newHasher().putString(pubKey, Charsets.UTF_8)
				.putString(privateKey, Charsets.UTF_8)
				.putString(getDate(date), Charsets.UTF_8).hash().toString();
	}

	public static String getToken(String pubKey) {
		return Hashing.md5().newHasher().putString(pubKey, Charsets.UTF_8)
				.putString(privateKey, Charsets.UTF_8)
				.putString(getDate(), Charsets.UTF_8).hash().toString();

	}

	public static boolean validToken(String token, String pubKey) {
		String confirm = getToken(pubKey);
		if (confirm.equals(token)) {
			return true;
		} else {
			return false;
		}
	}

	public static String getDate() {
		Date date = new Date(System.currentTimeMillis());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
		return sdf.format(date);
	}

	public static String getDate(Date now) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
		return sdf.format(now);
	}

	public static String getNextHour(Date now) {
		Date date = new Date(now.getTime() + 60 * 60 * 1000);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHH");
		return sdf.format(date);
	}
	public static void main(String[] args) throws InterruptedException {
		String t=getToken("sdf",new Date());
		System.out.println(t);
		Thread.sleep(2000);
		System.out.println(validToken(t, "sdf"));
	}
}