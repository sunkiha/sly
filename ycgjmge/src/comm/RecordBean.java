package comm;

import java.util.Date;

import com.jfinal.plugin.activerecord.Record;

public class RecordBean extends Record{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	public RecordBean(){
		this.set("createDate", new Date());
	}
}
