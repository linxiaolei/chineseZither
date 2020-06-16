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
<div class="m-detail">
	<div class="slide-banner">
	    <div class="swiper-wrapper">
	        <div class="swiper-slide"><img src="${pageContext.request.contextPath}/images/img/${product.imgurl}"></div>
	    </div>
	    <div class="swiper-pagination"></div>
		<a href="javascript:;" class="a-back"></a>
		<a href="javascript:;" class="a-cart"></a>
	</div><!-- //焦点图结束 -->

	<div class="d">
		<h3 class="d-title clamp">${product.intro}</h3>
		<div class="d-main flex">
			<p class="price cell">
				<del>吊牌价￥1499.00</del>
				<span class="s">￥<em class="n">${product.price}</em>.00</span>
			</p>
			<p class="discount"><b>3折</b></p>
		</div>
	</div>


<div class="buy-bar buy-fixed flex">
	<a class="add-cart cell" href="javascript:addCart();">加入购物车</a>
	<a class="go-cart" href="${pageContext.request.contextPath}/wx/cart"><span>购物车</span><i class="icon">1</i></a>
</div>

<script src="${pageContext.request.contextPath}/js/jquery-3.2.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper.js"></script>
<script>
//焦点图
var mySwiper = new Swiper ('.slide-banner', {
	pagination: '.swiper-pagination',
    autoplay: 3000,
    autoplayDisableOnInteraction: false
});
//参数初始化
window.onload = function () {
	//默认自提门店
    var cartNum = $('.go-cart .icon').text();
    if(cartNum > 0){
    	$('.go-cart .icon').css('display','block');
    }else{
    	$('.go-cart .icon').css('display','none');
    };
};

//加入购物车
function addCart(){
    var getCartNum = parseInt($('.go-cart .icon').text());
	setCartNum = getCartNum + 1;
    $('.go-cart .icon').text(setCartNum);
    
    var localData = {
            price: '${product.price}',
            number: 1,
            id: '${product.productId}',
            intro:'${product.intro}',
            imgurl:'${product.imgurl}'
        }
    localStorage.setItem(localData.id,JSON.stringify(localData));
};



</script>
</body>
</html>