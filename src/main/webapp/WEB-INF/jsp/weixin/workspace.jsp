<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0" />
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <link rel="shortcut icon" type="image/x-icon" href="http://res.wx.qq.com/mmbizwap/zh_CN/htmledition/images/icon/common/favicon22c41b.ico">
    <title>工作室简介</title>
    <link href="${pageContext.request.contextPath}/css/wx-mp.css" rel="stylesheet"/>
</head>
<body id="activity-detail" class="zh_CN mm_appmsg" ontouchstart="">
    <div id="js_article" class="rich_media">
        <div id="js_top_ad_area" class="top_banner"></div>
        <div class="rich_media_inner">
            <div id="page-content">
                <div id="img-content" class="rich_media_area_primary">
                    <h2 class="rich_media_title" id="activity-name">
                        琴行简介
                    </h2>
                    <div class="rich_media_meta_list">
                        <em id="post-date" class="rich_media_meta rich_media_meta_text">2020-5-1</em>
                        <em class="rich_media_meta rich_media_meta_text">作者</em>
                        <a class="rich_media_meta rich_media_meta_link rich_media_meta_nickname" href="javascript:void(0);" id="post-user">中筝琴行</a>
                    </div>
                    <div class="rich_media_thumb_wrp" id="media">
                    	<video class="rich_media_thumb" controls autoplay name= "video">
                    		<source src="http://203.205.137.163/vweixinp.tc.qq.com/1007_85521dcd82974213a0cd202df575cb7e.f10.mp4?vkey=291F380783E198CF71020B815483BDDBB8396B399BB11A3E57F4E3C45267996F8008FB381F466C2A55B113B7C4D101332B7301CF3BE80CD9874A9FEE9529A69C9BA9B3FADAB1EE0F1BE19B506A585242FEEDBAA6D948FAAC" type="video/mp4">
                    	</video>
                    </div>
                    <div class="rich_media_content " id="js_content">
                        <p style="text-indent: 2em;">${workspace.wIntro}</p>
                    </div>
                      <div class="rich_media_content " id="js_content">
                        <p><strong style="line-height: 1.6;">培训对象：</strong>${workspace.wObject }</p>
                         <p><strong style="line-height: 1.6;">授课方式：</strong>${workspace.wSchema }</p>
						 <p><strong style="line-height: 1.6;">温馨提示：</strong>${workspace.wRemind }</p>
						 <p><strong style="line-height: 1.6;">琴行地址：</strong>${workspace.wAddress }</p>
						  <p><strong style="line-height: 1.6;">联系电话：</strong>${workspace.wPhone }</p>
                       
                      
                       
	                        <p style="line-height: 3em;"><strong style="line-height: 1.6;">琴行老师简介</strong></p>
		                    
		                    <c:forEach items="${teacherList}" var="item">
							 <p style="text-align: center;">${item.username }</p>
							  <p style="text-align:center"><img data-s="300,640" data-type="jpg" data-src="${pageContext.request.contextPath}/images/img/teacher1.jpg"
	                                data-ratio="1" data-w="22" src="${pageContext.request.contextPath}/images/img/${item.img}"
	                                style="width:216px; visibility: visible !important; height: 145px"></p>
	                        <br><hr><br>
	                        <blockquote>
	                         ${item.intro }
	                        </blockquote>
	                        <br><hr><br>
                        </c:forEach>
                        
                        <table>
                            <caption>公告栏</caption>
                            <thead>
                                <tr>
                                	<th>关于举办中筝琴行小型音乐会的通知</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                	<td>
                                	<p style="text-indent: 2em;">${workspace.gContent }</p>
                                	<p><strong>时间：</strong>${workspace.gTime }</p>
                                	<p><strong>地点：</strong>${workspace.gAddress }</p>
                                	<p><strong>注意事项：</strong>${workspace.gRemind }</p>
                                	</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
 
</body>
</html>