package com.weixin;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.input.SAXBuilder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.xml.sax.InputSource;


import com.weixin.CoreService;
import com.weixin.SignUtil;
import com.weixin.util.MessageUtil;


@Controller
@RequestMapping("weixin")
public class CoreWexin {
	private static final long serialVersionUID = 4440739483644821986L;
	
	@RequestMapping(value="weixin",method=RequestMethod.GET)  // weixin/weixinOpe
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 微信加密签名
		String signature = request.getParameter("signature");
		// 时间戳
		String timestamp = request.getParameter("timestamp");
		// 随机数
		String nonce = request.getParameter("nonce");
		// 随机字符串
		String echostr = request.getParameter("echostr");

		PrintWriter out = response.getWriter();
		// 通过检验signature对请求进行校验，若校验成功则原样返回echostr，表示接入成功，否则接入失败
		if (SignUtil.checkSignature(signature, timestamp, nonce)) {
			out.print(echostr);
		}
		 
		out.close();
		out = null;
	}
	

	@Autowired
	CoreService coreService=new CoreService();
	@RequestMapping(value="weixin",method=RequestMethod.POST)
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 将请求、响应的编码均设置为UTF-8（防止中文乱码）
		//微信服务器POST消息时用的是UTF-8编码，在接收时也要用同样的编码，否则中文会乱码；
		//在响应消息（回复消息给用户）时，也将编码方式设置为UTF-8，原理同上；
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		// 调用核心业务类接收消息、处理消息
		
		String s=parse(request);
        System.out.println(s);
        Map<String,String> m =  parseXMl(s);
		
		
        String responseCon=coreService.processRequest(m.get("FromUserName"),m.get("ToUserName"),m.get("MsgType"),m.get("Event"),m.get("EventKey"),m.get("Content"));
		System.out.println(responseCon);
        PrintWriter out = response.getWriter();
		out.print(responseCon);
		out.close();
	}
	public static String parse(HttpServletRequest request) {
		BufferedReader buf = null;
        try {
            buf = new BufferedReader(new InputStreamReader(request.getInputStream(),"UTF-8"));
            StringBuilder sb = new StringBuilder();
            String line = null;
            while (null != (line = buf.readLine())) {
                sb.append(line);
            }
            if (sb.length() > 0) {
            	return sb.toString();
            	
            }
        } catch (Exception e) {
          return null;
        } finally {
            try {
                buf.close();
            } catch (Exception e) {
             
            }
        }
		return null;
	}

	private Map<String, String> parseXMl(String xmlDoc) throws Exception {
       
        StringReader xmlString = new StringReader(xmlDoc);
        // 创建新的输入源SAX 解析器将使用 InputSource 对象来确定如何读取 XML 输入
        InputSource source = new InputSource(xmlString);
        // 创建一个新的SAXBuilder
        SAXBuilder saxb = new SAXBuilder();
        // 通过输入源构造一个Document
        Document doc = saxb.build(source);
        Element root = doc.getRootElement();
        // 得到根元素所有子元素的集合
        List<?> node = root.getChildren();
        Map<String, String> m = new HashMap<String, String>();
        if (node.size() > 0) {
            for (int i = 0; i < node.size(); i++) {
                Element el = (Element) node.get(i);
                m.put(el.getName(), el.getText());
            }
        } else {
            m.put(root.getName(), root.getText());
        }
        return m;
    }
}
