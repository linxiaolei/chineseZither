<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
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
 <script src="${pageContext.request.contextPath}/js/common.js"></script>
 <script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
 <link href="${pageContext.request.contextPath}/css/shopin.css" rel="stylesheet"/>
  <link href="${pageContext.request.contextPath}/css/Reset.css" rel="stylesheet"/>
 <link href="${pageContext.request.contextPath}/css/CommonMB.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/css/Header.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/css/record.css" rel="stylesheet"/>
</head>
<body>
<header class="tc">
    <a href="javascript:history.go(-1)"></a>
    购买记录
</header>
<ul id="content">
	<c:forEach  items="${recordList}" var="item">
    <li>
        <div class="df jcsb f28 pr30 pl30 detail aic"><span>${item.create_time }</span><span>订单号：${item.orderId}</span></div>
        <ul class="all" style="display: none;">
            <li class="f24 g6 df jcsb aic bbe"><span>商品名称</span><span>商品数量</span></li>
            <li class="f24 g6 df jcsb aic"><span>${item.productIntro }</span><span>${item.productNum }</span></li>
        </ul>
    </li>
    </c:forEach>
    
</ul>
<script>
    $(function(){
        $(".detail").click(function(){
            $(".detail").removeClass("active");
            $(".all").hide();
            $(this).toggleClass("active").siblings(".all").toggle();
        });
    });
</script>
</body>
</html>