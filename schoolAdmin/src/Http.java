

import java.io.IOException;

import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PutMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

import com.alibaba.fastjson.JSONObject;
import com.sun.org.apache.bcel.internal.generic.FMUL;

import comm.S;


/**
 * HttpClient GET POST PUT 请求
 * @author huang
 * @date 2013-4-10
 */
public class Http
{

    /**
     * HttpClient GET请求
     * @author huang
     * @date 2013-4-9
     * @param uri
     * @return resStr 请求返回的JSON数据
     */
/*    public String doGet(String uri){
        String resStr = null;
        HttpClient htpClient = new HttpClient();
        GetMethod getMethod = new GetMethod(uri);
        getMethod.getParams().setParameter( HttpMethodParams.RETRY_HANDLER, new DefaultHttpMethodRetryHandler());     
        try{
            int statusCode = htpClient.executeMethod( getMethod );
//            log.info(statusCode);
            if(statusCode != HttpStatus.SC_OK){              
                log.error("Method failed: "+getMethod.getStatusLine());
                return resStr;
            }           
            byte[] responseBody = getMethod.getResponseBody();         
            resStr = new String(responseBody,HttpConstants.ENCODED);
        } catch (HttpException e) {
            log.error("Please check your provided http address!");  //发生致命的异常，可能是协议不对或者返回的内容有问题
        } catch (IOException e) {
            log.error( "Network anomaly" );  //发生网络异常
        }finally{
            getMethod.releaseConnection(); //释放连接
        }
        return resStr;
    }
    
    @SuppressWarnings( "deprecation" )
    public String doPost(String uri,String jsonObj){    
        String resStr = null;
        HttpClient htpClient = new HttpClient();
        PostMethod postMethod = new PostMethod(ConstantsDal.SERVER_URL+uri);
        postMethod.addRequestHeader( "Content-Type","application/json" );  
        postMethod.getParams().setParameter( HttpMethodParams.HTTP_CONTENT_CHARSET, HttpConstants.ENCODED );
        postMethod.setRequestBody( jsonObj );
        try{
            int statusCode = htpClient.executeMethod( postMethod );
//            log.info(statusCode);
            if(statusCode != HttpStatus.SC_OK){
              //post和put不能自动处理转发          301：永久重定向，告诉客户端以后应从新地址访问    302：Moved Temporarily  
                if(statusCode == HttpStatus.SC_MOVED_PERMANENTLY||statusCode == HttpStatus.SC_MOVED_TEMPORARILY){
                    Header locationHeader = postMethod.getResponseHeader( "location" );
                    String location = null;
                    if(locationHeader!=null){
                        location = locationHeader.getValue();
                        log.info("The page was redirected to :"+location);
                    }else{
                        log.info("Location field value is null");
                    }
                }else{
                    log.error("Method failed: "+postMethod.getStatusLine());                    
                }
                return resStr;
            }                     
            byte[] responseBody = postMethod.getResponseBody();           
            resStr = new String(responseBody,HttpConstants.ENCODED);  
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            postMethod.releaseConnection();
        }
        return resStr;
    }
    */
    /**
     * HttpClient PUT请求
     * @author huang
     * @date 2013-4-10
     * @return
     */
    @SuppressWarnings( "deprecation" )
    public static   String doPut(String uri,String jsonObj){
        String resStr = null;
        HttpClient htpClient = new HttpClient();
        PutMethod putMethod = new PutMethod(uri);
        putMethod.addRequestHeader( "Content-Type","application/json" );
        putMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"UTF-8");
        putMethod.setRequestBody( jsonObj );
        try{
            int statusCode = htpClient.executeMethod( putMethod );
            if(statusCode != HttpStatus.SC_OK){
                return null;
            }  
            byte[] responseBody = putMethod.getResponseBody();   
            resStr=new String(responseBody);
            resStr = new String(resStr.getBytes("ISO8859-1"),"UTF-8");
        }catch(Exception e){
            e.printStackTrace();
        }finally{
            putMethod.releaseConnection();
        }
        return resStr;
    }
	public static final MediaType JSON = MediaType
			.parse("application/json; charset=utf-8");

	static OkHttpClient client = new OkHttpClient();

	static String put(String url, String json) throws IOException {
		RequestBody body = RequestBody.create(JSON, json);
		Request request = new Request.Builder().url(url).post(body).build();
		Response response = client.newCall(request).execute();
		return response.body().string();
	}
    public static void main(String[] args) throws IOException {
    	String ip="http://192.168.0.123:8081";
    	//System.out.println(put("http://192.168.0.123:8080/iservo/userInfo/register",
		//		"{\"phone\":\"13605603423\",\"pwd\":\"E10ADC3949BA59ABBE56E057F20F883E\"}"));
		//System.out.println(doPut("http://192.168.0.123:8080/iservo/userInfo/register","{\"phone\":\"13605603423\",\"pwd\":\"E10ADC3949BA59ABBE56E057F20F883E\"}"));
		//System.out.println(put("http://192.168.0.123:8080/iservo/userInfo/login","{\"phone\":\"13605603423\",\"pwd\":\"E10ADC3949BA59ABBE56E057F20F883E\"}"));
		JSONObject jo=new JSONObject();
		jo.put("os",S.android);
		jo.put("imsi", S.oid());
		//FormatUtil.printJson(put(ip+"/iservo/main/init",jo.toJSONString()));
		jo.clear();
		jo.put("content", "sdfd");
		jo.put("category", 0);
		jo.put("contact", 2234343);
		//FormatUtil.printJson(put(ip+"/iservo/advice/advice",jo.toJSONString()));
		jo.clear();
		jo.put("videoCategoryId", 1);
		//FormatUtil.printJson(put(ip+"/iservo/channel/getVideoPage",jo.toJSONString()));
		//System.out.println(put(ip+"/iservo/channel/getVideoPage",jo.toJSONString()));
		jo.clear();
		jo.put("name", "美");
		//FormatUtil.printJson(put(ip+"/iservo/channel/getVideoKeyWordPage",jo.toJSONString()));
		FormatUtil.printJson(put(ip+"/iservo/userInfo/login",jo.toJSONString()));
	}
}
