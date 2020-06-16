package com.weixin;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.weixin.pojo.AccessToken;
import com.weixin.pojo.Button;
import com.weixin.pojo.CommonButton;
import com.weixin.pojo.ComplexButton;
import com.weixin.pojo.Menu;
import com.weixin.pojo.ViewButton;
import com.weixin.util.WeixinUtil;



public class MenuManager {
	private static Logger log = LoggerFactory.getLogger(MenuManager.class);

	public final static String REAL_URL="http://2r4chp.natappfree.cc/Examination_System/weixin/weixin/"; 
	
	
	public final static String appId="wxe8353a47ad116d33";
	public final static String appSecret = "d8ae46b94659bfd2bd39ef7b11ce1d49";
	
	public static void resultMenu(){
	
		AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);

		if (null != at) {
		
			int result = WeixinUtil.createMenu(getMenu(), at.getToken());

			
			if (0 == result)
				log.info("create menu false");
			else
				log.info("create menu success" + result);
		}
	}
	
	public static void main(String[] args) {
		
		String appId = MenuManager.appId;
		
		String appSecret = MenuManager.appSecret;
	
		AccessToken at = WeixinUtil.getAccessToken(appId, appSecret);

		if (null != at) {
	
			int result = WeixinUtil.createMenu(getMenu(),at.getToken());
//			WeixinUtil.test();
//			int result = WeixinUtil.postTemplate(at.getToken());
			if (0 == result)
				log.info("create menu false");
			else
				log.info("create menu success" + result);
		}
	}

	/**
	 * 
	 * 
	 * @return
	 */
	private static Menu getMenu() {

		
		CommonButton btn10 = new CommonButton();
		btn10.setName("工作室");
		btn10.setType("click");
		btn10.setKey("11");
		
		
//-------------------------------------------------------
		
		ViewButton btn20 = new ViewButton();
		btn20.setName("在线报名");
		btn20.setType("view");
		btn20.setUrl("http://2r4chp.natappfree.cc/Examination_System/wx/apply");

//------------------------------------------------------------		
		ViewButton btn31 = new ViewButton(); 
		btn31.setName("微商城");
		btn31.setType("view");
		btn31.setUrl("http://2r4chp.natappfree.cc/Examination_System/wx/mall");
	
		Menu menu = new Menu();
		menu.setButton(new Button[] { btn10, btn20, btn31 });

		return menu;
	}
}
