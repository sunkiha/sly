package comm;

public class UserNoLoginException extends RuntimeException {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	public String getMessage() {
		return "用户未登录";
	}
	
}
