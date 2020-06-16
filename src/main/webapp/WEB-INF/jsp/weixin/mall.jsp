<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta http-equiv="Access-Control-Allow-Origin" content="*" />
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
<meta content="no-cache" http-equiv="Cache-Control">
<title>微商城</title>
<link href="${pageContext.request.contextPath}/css/shopin.css" rel="stylesheet"/>
<link href="${pageContext.request.contextPath}/css/swiper.css" rel="stylesheet"/>
</head>

<body>

<div class="nav footer fixed-bar" data-trackid="全站-底部导航">
	
	<a href="${pageContext.request.contextPath}/wx/cart" data-trackid="全站-底部导航-购物车">购物车</a>
	<a href="${pageContext.request.contextPath}/wx/vip" data-trackid="全站-底部导航-我">我</a>
</div><!-- //底部导航结束 -->

<div class="header fixed-bar">
	<div class="left"><a href="category.html" class="a-cate" data-trackid="首页-顶部栏-分类"><span>分类</span></a></div>
	<div class="center">
		<div class="search">
			<form action="">
				<input class="s-input" type="search" autocomplete="off" placeholder="请输入搜索内容" autosave="unique">
				<a class="s-btn" href="javascript:;" data-trackid="搜索"></a>
			</form>
		</div>
	</div>
</div><!--//头部结束-->
<div class="content">
	<div class="slide-banner" data-trackid="首页-焦点图">
	    <div class="swiper-wrapper">
	        <div class="swiper-slide"><a href="#" data-trackid="首页-焦点图-1"><img src="${pageContext.request.contextPath}/images/img/f1.jpg"/></a></div>
	        <div class="swiper-slide"><a href="#" data-trackid="首页-焦点图-2"><img src="${pageContext.request.contextPath}/images/img/f2.jpg"/></a></div>
	    </div>
	    <div class="swiper-pagination"></div>
	</div><!-- //焦点图结束 -->

	<div class="floor mt">
		<div class="tab-wrapper">
			<ul class="tab-title">
				<li>商品</li>
			</ul>
			<div class="tab-content">
			
				<div class="tab-item" data-trackid="首页-精品推荐">
					<div class="list list-view">
						<ul>
							<c:forEach  items="${productList}" var="item">
							<li>
								<a class="list-item" href="${pageContext.request.contextPath}/wx/product?id=${item.productId}" data-trackid="首页-精品推荐-${item.productId}">
									<div class="p"><img class="p-pic" src="${pageContext.request.contextPath}/images/img/${item.imgurl}"></div>
									<div class="d">
										<h3 class="d-title clamp">${item.intro}</h3>
										<div class="d-main">
											<p class="price">
												<del>￥1499.00</del>
												<span class="s">￥<em class="n">${item.price}</em>.00</span>
											</p>
											<p class="discount"><b>3折</b></p>
										</div>
									</div>
								</a>
							</li>
							</c:forEach>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div><!-- //闪购&精品推荐 -->
</div>

<a href="javasctript:;" class="backtop"></a>
<script src="${pageContext.request.contextPath}/js/zepto.min.js"></script>
<script src="${pageContext.request.contextPath}/js/base.min.js"></script>
<script src="${pageContext.request.contextPath}/js/swiper.js"></script>
<script src="${pageContext.request.contextPath}/js/tab.js"></script>
<script src="${pageContext.request.contextPath}/js/shopin.js"></script>
<script>
$(getCode());
function getCode () { // 非静默授权，第一次有弹框
	var appId="wxe8353a47ad116d33";
	var redirect_uri="http://2r4chp.natappfree.cc/Examination_System/wx/mall";
	console.log(encodeURI(redirect_uri));
	
    const code = getUrlParam('code') // 截取路径中的code，如果没有就去微信授权，如果已经获取到了就直接传code给后台获取openId
    const state=getUrlParam('state');
    const local = window.location.href
    if (code == null || code === '') {
        window.location.href = 'https://open.weixin.qq.com/connect/oauth2/authorize?appid='+appId+'&redirect_uri='+encodeURI(redirect_uri)+'&response_type=code&scope=snsapi_userinfo&state=1#wechat_redirect'
    } else {
        this.getOpenId(code,state) //把code传给后台获取用户信息
    }
}
function getUrlParam(name) {
    var reg = new RegExp('(^|&)' + name + '=([^&]*)(&|$)')
    let url = window.location.href.split('#')[0]
    let search = url.split('?')[1]
    if (search) {
      var r = search.substr(0).match(reg)
      if (r !== null)
        return unescape(r[2])
      return null
    } else
      return null
  }
function getOpenId (code,state) { // 通过code获取 openId等用户信息，/api/user/wechat/login 为后台接口
    let _this = this;
    var appId="wxe8353a47ad116d33";
    var secret="d8ae46b94659bfd2bd39ef7b11ce1d49";
    var url='https://api.weixin.qq.com/sns/oauth2/access_token?appid='+appId+'&secret='+secret+'&code='+code+'&grant_type=authorization_code';
    $.ajax({
        type: "POST",
        url: "${pageContext.request.contextPath}/wx/getOpen",
        dataType: "json",
        contentType: "application/x-www-form-urlencoded;charset=UTF-8",
        data: {
        	code:code,
        	state: state
        },
        success: function (data) {
        	console.log(data);
            localStorage.setItem("openid",data.openid);
        }
    });

}


</script>
<script>
//焦点图
var mySwiper = new Swiper ('.slide-banner', {
	pagination: '.swiper-pagination',
    autoplay: 3000,
    autoplayDisableOnInteraction: false
})

//分类swiper
var titSwiper;
var conSwiper;
function goLocation(i){
	conSwiper.slideTo(i, 300, function(){});
	setClass(i);
}
var titSwiper = new Swiper('.swiper-title', {
    slidesPerView: 4.5
});

var conSwiper = new Swiper('.swiper-container', {
	pagination : '.pagination',
    preloadImages: false,
    lazyLoading: true
});
conSwiper.params.onSlideChangeEnd = function(){
	var index = conSwiper.activeIndex;
	var prevIndex = conSwiper.previousIndex;
	if (index > prevIndex){
		titSwiper.slideTo(index, 300, function() {});
		var slidleft = $("#slide" + index).offset().left;
		var slidwidth = $("#slide" + index).width();
		setClass(index);
	}else{
		titSwiper.slideTo(index, 300, function() {});
		setClass(index);
	};
};
$(".swiper-title").find('.swiper-slide').each(function(index, el) {
	$(el).on('click', function(){
		goLocation(index);
	});
});
function setClass(i) {
	$(".swiper-title").find('.swiper-slide').each(function(index, el) {
		if (index != i) {
			if ($(el).hasClass("active")) {
				$(el).removeClass("active");
			}
		} else {
			$(el).addClass("active");
		}
	});
};



//选项卡
$(".tab-wrapper").tab();
</script>
</body>
</html>