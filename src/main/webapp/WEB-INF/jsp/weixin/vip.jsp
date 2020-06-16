<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta content="no-cache" http-equiv="Cache-Control">
<title>微商城</title>
<link href="${pageContext.request.contextPath}/css/shopin.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/css/swiper.css" rel="stylesheet"/>
</head>


<body>
<div class="m-user flex">
	<!-- //用户头像、用户名称取微信头像用户名即可 -->
	<div class="img"><img src="${pageContext.request.contextPath}/images/img/userImg.jpg"></div>
	<div class="info cell">
		<p class="name">毛里求斯</p>
		<p class="phone">18511248857</p>
	</div>
	<div class="int">积分：201</div>
</div><!-- 用户信息结束 -->

<div class="table-view vip-list">
	<ul>
	    <li><a class="cell allOrder" href="${pageContext.request.contextPath}/wx/record">购买记录</a></li>
		<li><a class="v9" href="${pageContext.request.contextPath}/wx/advise">意见反馈</a></li>
	</ul>
</div><!-- //会员常用列表 -->
<div class="nav footer fixed-bar">
	<a href="${pageContext.request.contextPath}/wx/mall">首页</a>
	<a href="${pageContext.request.contextPath}/wx/cart">购物车</a>
	<a href="${pageContext.request.contextPath}/wx/vip">我</a>
</div><!-- //底部导航结束 -->
</body>
</html>
