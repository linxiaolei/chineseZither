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
</head>

<body>
<div class="header">
	<div class="left"><a href="javascript:;" class="a-back"><span>返回</span></a></div>
	<div class="center">
		<h1>订单详情</h1>
	</div>
	<div class="right"><a href="javascript:;" class="a-more"><span>更多</span></a></div>
</div><!--//头部结束-->
<div class="nav sub-nav j-nav">
	<a class="on" href="${pageContext.request.contextPath}/wx/mall">首页</a>
	<a href="${pageContext.request.contextPath}/wx/cart">购物车</a>
	<a href="${pageContext.request.contextPath}/wx/vip">我</a>
</div><!-- //二级导航结束 -->

<div class="content">
	<div class="order-detail">
		<div class="pickup-code">
			<div class="delivery">
				<div class="num-code"><p>${orderId}</p><span>您已成功付款</span></div>
			</div>
			<div class="cut-line"><span>或直接扫描二维码</span></div>
			<div class="qr-code" id="qr-code"></div>
		</div><!-- //自提订单 ：只自提订单显示-->
		<div class="address order-address">
			<div class="info">
				收货人：<p class="name">刘伯温</p>
				<p class="phone">18511248858</p>
			</div>
			<div class="details">收货地址：北京市朝阳区香宾路66-1号朝来天陆综合服务楼四层上品折扣办公区</div>
		</div><!-- //收货地址 -->
		
		<div class="btn-box">
			<a href="${pageContext.request.contextPath}/wx/mall" class="btn btn-block btn-success">再逛逛</a><!-- //刚确认订单显示： 再逛逛 -->
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>

<script src="${pageContext.request.contextPath}/js/qrcode.min.js"></script>
<script>
$(".j_select").change(function(){
	var value = $(this).find("option:selected").text();
    $(this).prev('.j_multi').text(value);
});
$('#j_address').on('tap', function(event) {
	window.location.href="address.html"
});
  
</script>
<script>
var qrcode = new QRCode(document.getElementById("qr-code"), {
	width : 200,
	height : 200
});

function makeCode () {
	qrcode.makeCode('123456');
}
makeCode();
</script>
</body>
</html>