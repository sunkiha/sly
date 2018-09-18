import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import redis.clients.jedis.Jedis;

public class main {
	  public static Date getThisWeekMonday(Date date) {  
	        Calendar cal = Calendar.getInstance();  
	        cal.setTime(date);  
	        // 获得当前日期是一个星期的第几天  
	        int dayWeek = cal.get(Calendar.DAY_OF_WEEK);  
	        if (1 == dayWeek) {  
	            cal.add(Calendar.DAY_OF_MONTH, -1);  
	        }  
	        // 设置一个星期的第一天，按中国的习惯一个星期的第一天是星期一  
	        cal.setFirstDayOfWeek(Calendar.MONDAY);  
	        // 获得当前日期是一个星期的第几天  
	        int day = cal.get(Calendar.DAY_OF_WEEK);  
	        // 根据日历的规则，给当前日期减去星期几与一个星期第一天的差值  
	        cal.add(Calendar.DATE, cal.getFirstDayOfWeek() - day);  
	        return cal.getTime();  
	    }  
	public static void main(String[] args) {
		System.out.println((int)((Math.random()*9+1)*1000));
		Date today = new Date();
		System.out.println(today.toLocaleString());
        Calendar c=Calendar.getInstance();
        c.setTime(today);
        int weekday=c.get(Calendar.DAY_OF_WEEK);
        System.out.println(getThisWeekMonday(today).toLocaleString());
	/*	HashMap map=new HashMap();
        map.put("stockStatId","sd");
        map.put("userNo","simon");
        map.put("token","sdsd");
         String jsonObject = JSON.toJSONString(map);
         System.out.println(jsonObject);
         JSONObject jsonObject1=new JSONObject();
         jsonObject1.put("userNo","simon");
         jsonObject1.put("token","sd");
   System.out.println(jsonObject1.toString());   
   main2();*/
	}
	public static  void main2() {
		Jedis jedis=new Jedis("localhost");
		System.out.println(jedis.ping());
		//jedis.set("sdf", "斯蒂芬斯蒂芬森的");
		System.out.println(jedis.get("sdf"));
	     Set<String> keys = jedis.keys("*"); 
	        Iterator<String> it=keys.iterator() ;   
	        while(it.hasNext()){   
	            String key = it.next();   
	            System.out.println(key);   
	        }
	        
	        Map<String, String> map = new HashMap<String, String>();
	        map.put("name", "xinxin");
	        map.put("age", "22");
	        map.put("qq", "123456");
	        jedis.hmset("user", map);// hmset方法存入后，该user对象在redis里面是一个hash类型的数据
	        // 第一个参数是存入redis中map对象的key，后面跟的是放入map中的对象的key，后面的key可以跟多个，是可变参数
	        jedis.set("age", "22");
	        jedis.incr("age");
	        System.out.println(jedis.get("age"));
	        List<String> rsmap = jedis.hmget("user", "name", "age");
	        System.out.println(rsmap);
		/*  final Outputter output = new Outputter();  
	        new Thread() {  
	            public void run() {  
	            	 output.output("a");  
	            }  
	        }.start();        
	        new Thread() {  
	            public void run() {  
	                output.output("b");  
	            }  
	        }.start();  
	        new Thread(new Runnable() {
				
				@Override
				public void run() {
					// TODO Auto-generated method stub
					
				}
			}).start();*/
	    }  
	}


class Outputter {  
	Lock lock=new  ReentrantLock();
    public void output(String name) {  
        // TODO 为了保证对name的输出不是一个原子操作，这里逐个输出name的每个字符  
    	lock.lock();
    	 for(int i = 0; i < 1000; i++) {  
             System.out.println(name+i);  
             // Thread.sleep(10);  
         } 
    	 lock.unlock();
      /*  for(int i = 0; i < name.length(); i++) {  
            System.out.print(name.charAt(i));  
            // Thread.sleep(10);  
        }  */
    }  
}    