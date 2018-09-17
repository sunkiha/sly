import java.util.HashMap;
import java.util.Map;

import comm.S;
import cn.jpush.api.JPushClient;
import cn.jpush.api.common.resp.APIConnectionException;
import cn.jpush.api.common.resp.APIRequestException;
import cn.jpush.api.push.PushResult;
import cn.jpush.api.push.model.Platform;
import cn.jpush.api.push.model.PushPayload;
import cn.jpush.api.push.model.audience.Audience;
import cn.jpush.api.push.model.notification.Notification;

public class Push {
	public static void main(String[] args) throws APIConnectionException, APIRequestException {
      JPushClient jPushClient=new JPushClient(S.masterSecret, S.appKey);
       String title ="test";
		String summary = "testcontent";
		Map<String,String> extras=new HashMap<String, String>();
		extras.put("newsId", "testnewsId");
		extras.put("createDate", "201-1-3");
       PushPayload payload = PushPayload.newBuilder()
               .setPlatform(Platform.android())
               .setAudience(Audience.all())
               .setNotification(Notification.android(summary, title, extras))
               .build();
       S.getJPushClient().sendPush(payload);
		/*   JPushClient jpushClient = new JPushClient(S.masterSecret, S.appKey, 3);
	        
	        // For push, all you need do is to build PushPayload object.
	        PushPayload payload = PushPayload.alertAll("d");
	       
	        try {
	            PushResult result = jpushClient.sendPush(payload);
	            
	        } catch (APIConnectionException e) {
	            
	        } catch (APIRequestException e) {
	        }*/
	}
}
