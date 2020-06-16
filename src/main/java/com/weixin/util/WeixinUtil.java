package com.weixin.util;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ConnectException;
import java.net.URL;
import java.util.Date;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLSocketFactory;
import javax.net.ssl.TrustManager;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.weixin.MyX509TrustManager;
import com.weixin.pojo.AccessToken;
import com.weixin.pojo.Menu;
import com.weixin.resp.BaseMessage;
import com.weixin.resp.InMessage;
import com.weixin.resp.NewsMessage;

import net.sf.json.JSONObject;

/**
 * 公众平台通用接口工具类
 * 
 */
public class WeixinUtil {
	private static Logger log = LoggerFactory.getLogger(WeixinUtil.class);

	/**
	 * 发起https请求并获取结果
	 * 
	 * @param requestUrl 请求地址
	 * @param requestMethod 请求方式（GET、POST）
	 * @param outputStr 提交的数据
	 * @return JSONObject(通过JSONObject.get(key)的方式获取json对象的属性值)
	 */
	public static JSONObject httpRequest(String requestUrl, String requestMethod, String outputStr) {
		JSONObject jsonObject = null;
		StringBuffer buffer = new StringBuffer();
		try {
			// 创建SSLContext对象，并使用我们指定的信任管理器初始化
			TrustManager[] tm = { new MyX509TrustManager() };
			SSLContext sslContext = SSLContext.getInstance("SSL", "SunJSSE");
			sslContext.init(null, tm, new java.security.SecureRandom());
			// 从上述SSLContext对象中得到SSLSocketFactory对象
			SSLSocketFactory ssf = sslContext.getSocketFactory();

			URL url = new URL(requestUrl);
			HttpsURLConnection httpUrlConn = (HttpsURLConnection) url.openConnection();
			httpUrlConn.setSSLSocketFactory(ssf);

			httpUrlConn.setDoOutput(true);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			// 设置请求方式（GET/POST）
			httpUrlConn.setRequestMethod(requestMethod);

			if ("GET".equalsIgnoreCase(requestMethod))
				httpUrlConn.connect();

			// 当有数据需要提交时
			if (null != outputStr) {
				OutputStream outputStream = httpUrlConn.getOutputStream();
				// 注意编码格式，防止中文乱码
				outputStream.write(outputStr.getBytes("UTF-8"));
				outputStream.close();
			}

			// 将返回的输入流转换成字符串
			InputStream inputStream = httpUrlConn.getInputStream();
			InputStreamReader inputStreamReader = new InputStreamReader(inputStream, "utf-8");
			BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

			String str = null;
			while ((str = bufferedReader.readLine()) != null) {
				buffer.append(str);
			}
			bufferedReader.close();
			inputStreamReader.close();
			// 释放资源
			inputStream.close();
			inputStream = null;
			httpUrlConn.disconnect();
			jsonObject = JSONObject.fromObject(buffer.toString());
		} catch (ConnectException ce) {
			log.error("Weixin server connection timed out.");
		} catch (Exception e) {
			log.error("https request error:{}", e);
		}
		return jsonObject;
	}
	
	// 获取access_token的接口地址（GET） 限200（次/天）
	public final static String access_token_url = "https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=APPID&secret=APPSECRET";
	
	/**
	 * 获取access_token
	 * 
	 * @param appid 凭证
	 * @param appsecret 密钥
	 * @return
	 */
	public static AccessToken getAccessToken(String appid, String appsecret) {
		AccessToken accessToken = null;

		String requestUrl = access_token_url.replace("APPID", appid).replace("APPSECRET", appsecret);
		JSONObject jsonObject = httpRequest(requestUrl, "GET", null);
		System.out.println("获取凭证："+jsonObject.toString());
		// 如果请求成功
		if (null != jsonObject) {
			try {
				accessToken = new AccessToken();
				accessToken.setToken(jsonObject.getString("access_token"));
				accessToken.setExpiresIn(jsonObject.getInt("expires_in"));
				
			//	System.out.println(accessToken.getExpiresIn());
			} catch (Exception e) {
				accessToken = null;
				// 获取token失败
				log.error("获取token失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));
			}
		}
		return accessToken;
	}
	
	
	// 菜单创建（POST） 限100（次/天）
	

	/**
	 * 创建菜单
	 * 
	 * @param menu 菜单实例
	 * @param accessToken 有效的access_token
	 * @return 0表示成功，其他值表示失败
	 */
	public static String menu_create_url = "https://api.weixin.qq.com/cgi-bin/menu/create?access_token=ACCESS_TOKEN";
	public static int createMenu(Menu menu, String accessToken) {
		int result = 0;

		// 拼装创建菜单的url
		String url = menu_create_url.replace("ACCESS_TOKEN", accessToken);
		// 将菜单对象转换成json字符串
		String jsonMenu = JSONObject.fromObject(menu).toString();
		System.out.println(jsonMenu);
		// 调用接口创建菜单
		JSONObject jsonObject = httpRequest(url, "POST", jsonMenu);
		System.out.println("创建菜单："+jsonObject.toString());
		if (null != jsonObject) {
			if (0 != jsonObject.getInt("errcode")) {
				result = jsonObject.getInt("errcode");
				log.error("创建菜单失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));
			}
		}

		return result;
	}
	
	public static String templateUrl = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=ACCESS_TOKEN";
	public static int postTemplate(String data) {
		int result = 0;
		String appId="wxe8353a47ad116d33";
		String appSecret="d8ae46b94659bfd2bd39ef7b11ce1d49";
        AccessToken token=getAccessToken(appId,appSecret);
		String url = templateUrl.replace("ACCESS_TOKEN", token.getToken());
		System.out.println(data);
		
		JSONObject jsonObject = httpRequest(url, "POST", data);
		System.out.println("success："+jsonObject.toString());
		if (null != jsonObject) {
			if (0 != jsonObject.getInt("errcode")) {
				result = jsonObject.getInt("errcode");
				log.error("推送失败 errcode:{} errmsg:{}", jsonObject.getInt("errcode"), jsonObject.getString("errmsg"));
			}
		}

		return result;
	}
	public static String test(String url){
//		String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid=wxe8353a47ad116d33&secret=d8ae46b94659bfd2bd39ef7b11ce1d49&code=0211b7Rq1HxPdj0NxDUq12A9Rq11b7Rk&grant_type=authorization_code";
		System.out.println("sss");
		JSONObject jsonObject = httpRequest(url, "POST", null);
		System.out.println(jsonObject.toString());
		return jsonObject.toString();
	}
	public static String getVideo(){
		
		String appId="wxe8353a47ad116d33";
		String appSecret="d8ae46b94659bfd2bd39ef7b11ce1d49";
        AccessToken token=getAccessToken(appId,appSecret);
		String url= "https://api.weixin.qq.com/cgi-bin/media/get?access_token="+token.getToken()+"&media_id=tbaASizq_8LyZCq-gCE9YZWFPcdWhghMPzHbbA9o4qvsFyYo3LHYcHTjw1PfinVX";
		
		System.out.println("sss");
		JSONObject jsonObject = httpRequest(url, "POST", null);
		System.out.println(jsonObject.toString());
		return jsonObject.toString();
	}
	
	public static String postVideo(){
		
		String appId="wxe8353a47ad116d33";
		String appSecret="d8ae46b94659bfd2bd39ef7b11ce1d49";
        AccessToken token=getAccessToken(appId,appSecret);
		String url= "https://api.weixin.qq.com/cgi-bin/media/upload?access_token="+token.getToken()+"&type=TYPE";
	    
		System.out.println("sss");
		JSONObject jsonObject = httpRequest(url, "POST", null);
		System.out.println(jsonObject.toString());
		return jsonObject.toString();
	}
	
	
}
