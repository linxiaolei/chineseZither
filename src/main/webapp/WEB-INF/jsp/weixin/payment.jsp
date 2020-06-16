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
		<h1>确认订单</h1>
	</div>
	<div class="right"><a href="javascript:;" class="a-more"><span>更多</span></a></div>
</div><!--//头部结束-->
<div class="nav sub-nav j-nav">
	<a class="on" href="index.html">首页</a>
	<a href="category.html">分类</a>
	<a href="cart.html">购物车</a>
	<a href="vip.html">我</a>
</div><!-- //二级导航结束 -->

<div class="content">
	<div class="order-buy">
		<div id="j_address" class="address order-address">
			<div class="info">
				收货人：<p class="name">刘伯温</p>
				<p class="phone">18511248858</p>
			</div>
			<div class="details">收货地址：北京市朝阳区香宾路66-1号朝来天陆综合服务楼四层上品折扣办公区</div>
		</div><!-- //收货地址 -->
		<div class="order-list mt">
			
		</div><!-- //购买商品 -->

		<div class="bottom-bar mt">
			<div class="total-price">
				<div class="compute">
					<p class="realPay"><span class="subtotal">合计：￥</span><strong class="price">402.00</strong></p>
					
				</div>
				<div class="submitOrder">
					<input type="button" class="btn btn-pay j_submit" value="确认" onClick="success()">
				</div>
			</div>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<script>
$(init);
function init(){
	var total=0;
	for (var i = 0; i < localStorage.length; i++) {
	        var data = localStorage.getItem(localStorage.key(i));
	        if(localStorage.key(i)!="openid"){
	        	 var cart=JSON.parse(data);
	 	        console.log(cart);
	 	        $('.order-list').append(
	 	        	'<div class="small">'+
	 					'<div class="p"><img src="${pageContext.request.contextPath}/images/img/'+cart.imgurl+'"></div>'+
	 					'<div class="d">'+
	 						'<a href="#"><h3 class="d-title clamp">'+cart.intro+'</h3></a>'+
	 						'<div class="d-main">'+
	 							'<div class="sub flex">'+
	 								'<p class="text">共'+cart.number+'件</p>'+
	 								'<span class="price">'+cart.price+'</span>'+
	 							'</div>'+
	 						'</div>'+
	 					'</div>'+
	 				'</div>'
	 	        );
	 	        total+=cart.number*cart.price;
	 	        $(".price").text(total);
	        }
	       
	       
	}
}
function goToSuccess(){
	location.href="${pageContext.request.contextPath}/wx/orderDetail"
}
function success(){
	var orderId=randomString("11","0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ");
	for (var i = 0; i < localStorage.length; i++) {
        var data = localStorage.getItem(localStorage.key(i));
        if(localStorage.key(i)!="openid"){
        	   var cart=JSON.parse(data);   
               doAjax(cart,orderId);
        }
     
	}
	location.href="${pageContext.request.contextPath}/wx/orderDetail?orderId="+orderId;
}
function doAjax(cart,orderId){
	var id=randomString("5","123456789");
    var openid=localStorage.getItem("openid");
   console.log(openid);
	console.log(id);
		$.ajax({
	        type: "POST",
	        url: "${pageContext.request.contextPath}/wx/setOrder",
	        dataType: "json",
	        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
	        data: {
	        	"oId": id,
				"orderId":orderId,
				"productId": cart.id,
				"productNum":cart.number,
				"productIntro":cart.intro,
				"create_time":"2020-4-20",
				"openId":openid
	        }
	            ,
	        success: function (data) {
	            
	        }
	    });
	
	
}
	
function randomString(length, chars) {   
    var result = '';
    for (var i = length; i > 0; --i)
      result += chars[Math.floor(Math.random() * chars.length)];
    return result;
  }
  


</script>
</body>
</html>
