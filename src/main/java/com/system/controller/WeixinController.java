package com.system.controller;

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSON;
import net.sf.json.JSONObject;

import com.system.exception.CustomException;
import com.system.po.*;
import com.system.service.*;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.weixin.pojo.AccessToken;
import com.weixin.util.*;
@Controller
@RequestMapping(value = "wx")
public class WeixinController {
	@Resource(name ="productServiceImpl")
    private ProductService productService;
	
	@Resource(name ="orderServiceImpl")
    private OrderService orderService;
	
	
	@Resource(name ="studentServiceImpl")
    private StudentService studentService;
	
	
	@Resource(name = "userloginServiceImpl")
	private UserloginService userloginService;
	
	@Resource(name = "collegeServiceImpl")
	private CollegeService collegeService;
	
	@Resource(name = "teacherServiceImpl")
	private TeacherService teacherService;
	
	@Resource(name = "workspaceServiceImpl")
	private WorkspaceService workspaceService;
	
	@RequestMapping(value = "/apply", method = {RequestMethod.GET})
    public String apply(Model model) throws Exception {
		
		 List<College> list = collegeService.finAll();
	     List<TeacherCustom> teacher = teacherService.findAll();
	     model.addAttribute("collegeList", list);
	     model.addAttribute("teacherList", teacher);
		
		 return "weixin/apply";
    }
	
	@RequestMapping(value = "/oauth")
    public void oauth(HttpServletResponse response) throws Exception {
		String appId="wxe8353a47ad116d33";
		String redirect_uri="http://rwp7nt.natappfree.cc/Examination_System/wx/getOpen";
		String path=URLEncoder.encode(redirect_uri, "UTF-8");
		String url="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appId
				+"&redirect_uri="+path
				+"&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect";
		response.sendRedirect(url);
    }
	
	@RequestMapping(value = "/getOpen",method = {RequestMethod.POST})
    public void getOpen(HttpServletRequest request,HttpServletResponse response,Model model) throws Exception {
		String code=request.getParameter("code");
		String state=request.getParameter("state");
		String appId="wxe8353a47ad116d33";
		String secret="d8ae46b94659bfd2bd39ef7b11ce1d49";
		System.out.println(code);
		
		String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appId
				+"&secret="+secret
				+"&code="+code
				+"&grant_type=authorization_code";
		System.out.println(url);
		JSONObject jsonobject=WeixinUtil.httpRequest(url,"POST",null);
		System.out.print("over");
		System.out.println(jsonobject.toString());
		
		PrintWriter out = response.getWriter();
		out.print(jsonobject.toString());
		out.close();
    }
//	@RequestMapping(value = "/mall", method = {RequestMethod.GET})
//    public void mall(HttpServletRequest request,Model model) throws Exception {
//		String code=request.getParameter("code");
//		String state=request.getParameter("state");
//		String appId="wxe8353a47ad116d33";
//		String secret="d8ae46b94659bfd2bd39ef7b11ce1d49";
//
//		String url="https://api.weixin.qq.com/sns/oauth2/access_token?appid="+appId
//				+"&secret="+secret
//				+"&code="+code
//				+"&grant_type=authorization_code";
//		System.out.println(url);
//		String s=WeixinUtil.test(url);
//		System.out.print("over");
//		System.out.println(s);
//    }
	@RequestMapping(value = "/mall", method = {RequestMethod.GET})
    public String mall(HttpServletResponse response,Model model) throws Exception {
		List<Product> list = null;
        list = productService.findAll();
        model.addAttribute("productList", list);
		return "weixin/mall";
    }
	@RequestMapping(value = "/cart", method = {RequestMethod.GET})
    public String cart() throws Exception {
		 return "weixin/cart";
    }
	@RequestMapping(value = "/product", method = {RequestMethod.GET})
    public String product(Integer id,Model model) throws Exception {
	      
	        Product product = productService.findById(id);
	        System.out.println("========="+product);
	        model.addAttribute("product", product);
		return "weixin/product";
    }
	@RequestMapping(value = "/payment", method = {RequestMethod.GET})
    public String payment() throws Exception {
		 return "weixin/payment";
    }
	@RequestMapping(value = "/vip", method = {RequestMethod.GET})
    public String vip() throws Exception {
		 return "weixin/vip";
    }
	@RequestMapping(value = "/advise", method = {RequestMethod.GET})
    public String advise() throws Exception {
		 return "weixin/advise";
    }
	@RequestMapping(value = "/record", method = {RequestMethod.GET})
    public String record(Model model) throws Exception {
		List<Order> list = null;
        list = orderService.findAll();
        System.out.println(list);
        model.addAttribute("recordList", list);
		return "weixin/record";
    }
	
	@RequestMapping(value = "/setOrder", method = {RequestMethod.POST})
	@ResponseBody
    public void registerUserName(HttpServletRequest request) throws Exception{
		Order order=new Order();
		
		String paraName = null;
		
        Map<String, Object> parameters = new HashMap<>();
        //获取请求参数并转换
        Enumeration<String> enu = request.getParameterNames();
        while (enu.hasMoreElements()) {
            paraName = enu.nextElement();
            System.out.println(paraName);
        
            if(paraName.equals("oId")) {
            	System.out.println(paraName);
            	order.setoId(Integer.parseInt(request.getParameter(paraName)));
            } 
            if(paraName.equals("orderId")){
            	order.setOrderId(request.getParameter(paraName));
            }
            if(paraName.equals("productId")) {
            	order.setProductId(Integer.parseInt(request.getParameter(paraName)));
            }
            if(paraName.equals("productNum")) {
            	order.setProductNum(Integer.parseInt(request.getParameter(paraName)));
            }
            if(paraName.equals("productIntro")){
            	order.setProductIntro(request.getParameter(paraName));
            }
            if(paraName.equals("openId")){
            	order.setOpenId(request.getParameter(paraName));
            }
           
            
        }
        orderService.save(order);
        Date t=new Date();
        SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String time=df.format(t);
        String data="{\r\n" + 
        		"        		\"touser\":\""+order.getOpenId()+"\",\r\n" + 
        		"                \"template_id\":\"ZpX-_lAddXd347Dui8Xl7YAYzTlVakl3Vo9N90Dz_6A\",   \r\n" + 
        		"                \"data\":{\r\n" + 
        		"                        \"first\": {\r\n" + 
        		"                            \"value\":\"恭喜你购买成功！\",\r\n" + 
        		"                            \"color\":\"#173177\"\r\n" + 
        		"                        },\r\n" + 
        		"                        \"productName\":{\r\n" + 
        		"                            \"value\":\""+order.getProductIntro()+"\",\r\n" + 
        		"                            \"color\":\"#173177\"\r\n" + 
        		"                        },\r\n" + 
        		"                        \"productNum\": {\r\n" + 
        		"                            \"value\":\""+order.getProductNum()+"\",\r\n" + 
        		"                            \"color\":\"#173177\"\r\n" + 
        		"                        },\r\n" + 
        		"                        \"createTime\": {\r\n" + 
        		"                            \"value\":\""+time+"\",\r\n" + 
        		"                            \"color\":\"#173177\"\r\n" + 
        		"                        },\r\n" + 
        		"                        \"remark\":{\r\n" + 
        		"                            \"value\":\"欢迎再次购买！\",\r\n" + 
        		"                            \"color\":\"#173177\"\r\n" + 
        		"                        }\r\n" + 
        		"                }\r\n" + 
        		"            }";
        	


       int result=WeixinUtil.postTemplate(data);
        
        
    }
	@RequestMapping(value = "/orderDetail", method = {RequestMethod.GET})
    public String orderDetail(String orderId,Model model) throws Exception {
		 model.addAttribute("orderId", orderId);
		 return "weixin/orderDetail";
    }
	
	@RequestMapping(value = "/apply", method = {RequestMethod.POST})
    public String addStudent(StudentCustom studentCustom, Model model) throws Exception {

		Boolean result = studentService.save(studentCustom);

        if (!result) {
            model.addAttribute("message", "失败");
            return "error";
        }
 
        Userlogin userlogin = new Userlogin();
        userlogin.setUsername(studentCustom.getUserid().toString());
        userlogin.setPassword("123");
        userlogin.setRole(2);
        userloginService.save(userlogin);
        
        return "weixin/apply";
    }
	@RequestMapping(value = "/workspace", method = {RequestMethod.GET})
    public String workspace(Model model) throws Exception {
		Workspace workspace=workspaceService.findById(1);
		List<TeacherCustom> teacher = teacherService.findAll();
		model.addAttribute("workspace",workspace);
		model.addAttribute("teacherList", teacher);
	    return "weixin/workspace";
    }
	
	
	@RequestMapping(value = "/postfile", method = {RequestMethod.POST})
    public void postfile(HttpServletRequest request) throws Exception {
		
		String appId="wxe8353a47ad116d33";
		String appSecret="d8ae46b94659bfd2bd39ef7b11ce1d49";
        AccessToken token=WeixinUtil.getAccessToken(appId,appSecret);
		String url= "https://api.weixin.qq.com/cgi-bin/media/uploadnews?access_token="+token.getToken();
	   
	
		
    }
}
