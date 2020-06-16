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
		<h1>购物车</h1>
	</div>
</div><!--//头部结束-->

<div class="content">
	<div class="cart-main">
		<div class="cart-list">
			<div class="cart-shop">
				<div class="cart-title"></div>
				<div class="cart-edit"><a href="javascript:;" class="btn btn-default cartEdit">编辑</a></div>
			</div>
			<div class="cart-box">
				
			</div>
			<div class="cart-group cart-footer">
				<div class="cart-icb"><input type="checkbox" name="shop" class="icon-checkbox selectAll"></div>
				<div class="cart-item">
					<button class="btn btn-pay disabled">结算</button>
					<div class="total">总计：<b>￥0.00</b></div>
					<div class="quantity">共<b>0</b>件商品</div>
				</div>
			</div>
		</div><!-- //门店结算结束 -->
			
	</div>
</div>

<script src="${pageContext.request.contextPath}/js/zepto.min.js"></script>
<script src="${pageContext.request.contextPath}/js/base.min.js"></script>
<script src="${pageContext.request.contextPath}/js/shopin.js"></script>
<script>
	$(init);
	function init(){
		for (var i = 0; i < localStorage.length; i++) {
		        var data = localStorage.getItem(localStorage.key(i));
		        if(localStorage.key(i)!="openid"){
		        	var cart=JSON.parse(data);
			        console.log(cart);
			        $(".cart-box").append(
			        		'<div class="cart-group">'+
							'<div class="cart-icb"><input type="checkbox" name="shop" class="icon-checkbox setSelectAll"></div>'+
			        		'<div class="cart-item">'+
							'<div class="small">'+
							
								'<div class="p"><a href="${pageContext.request.contextPath}/wx/product"><img src="${pageContext.request.contextPath}/images/img/'+cart.imgurl+'"/></a></div>'+
								'<div class="d">'+
									'<a href="${pageContext.request.contextPath}/wx/product"><h3 class="d-title clamp">'+cart.intro+'</h3></a>'+
									'<div class="d-main">'+
										'<div class="sub">'+
											'<p class="quantity"><i>x</i>1</p>'+
											'<span class="price">'+
												'<span class="s">￥<em class="n">'+cart.price+'</em>.00</span><del>吊牌价￥1499.00</del>'+
											'</span>'+
										'</div>'+
										'<div class="opt">'+
											'<div class="number"><button type="button" class="decrease">-</button><input type="number" class="num" value="1" min="1" max="库存" name="quantity"><button type="button" class="increase">+</button></div>'+
											'<i class="icon-del" id="'+cart.id+'"></i>'+
										'</div>'+
									'</div>'+
								'</div>'+
							'</div>'+
						'</div>'+
						'<div>'

			        )
		        }
		        
		}
		doSomething();
	}
	function doSomething(){
		$(".cart-main").find('.cart-list').each(function() {
			var obj = $(this);
			console.log(obj);
			obj.find('.cartEdit').click(function() {
				if(!$(this).hasClass('active')){
					$(this).addClass('active').text('确定');
					obj.addClass('editOrder');
				}else{
					$(this).removeClass('active').text('编辑');
					
					obj.removeClass('editOrder');
				}
				
			});

			//全选
			obj.find('.selectAll').on('change', 'input', function() {
				var ssa = obj.find('.setSelectAll');
				var value = this.checked;
				if(value == true) {
					for(var i = 0; i < ssa.length; i++) {
						ssa[i].checked = true;
						ssa.parent().parent().addClass('checked');
					}
				}else{
					for(var i = 0; i < ssa.length; i++){
						ssa[i].checked = false;
						ssa.parent().parent().removeClass('checked');
					}
				}
				setButton();
				setTotal();
			});
			obj.find('.setSelectAll').on('change', 'input', function() {
				var ssa = obj.find('.setSelectAll');
				var count = ssa.length;
				var selectCount = 0;
				var value = this.checked;
				for(var i = 0; i < count; i++) {
					if(ssa[i].checked == true){
						selectCount++;
					}
				}
				if(value == true) {
					$(this).parent().parent().addClass('checked');
				}else{
					$(this).parent().parent().removeClass('checked');
				}
				if(count == selectCount) {
					obj.find('.selectAll').prop('checked', true);
				}else{
					obj.find('.selectAll').prop('checked', false);
				}
				setButton();
				setTotal();
			});

			//删除
			obj.find('.icon-del').click(function() {
				console.log("inininiii")
				var th=obj.find('.icon-del')
				var id=$(th).attr('id');
				 for (i = 0; i < localStorage.length; i++) {
			            if (id == localStorage.key(i)) {
			            	 localStorage.removeItem(localStorage.key(i));
			            }
			        }
				var len = obj.find('.cart-box .cart-group').length;
				if( len <= 1){
					$(this).closest(".cart-list").remove();
				}else{
					$(this).closest(".cart-group").remove();
				}
				
				console.log(th);
				setTotal();
			});

			//调整购买数量
			obj.find(".increase").click(function() {
				var n = $(this).parent().find('.num');
				n.val(parseInt(n.val()) + 1)
				setTotal();
				//ajax代码可以放这里传递到数据库实时改变总价
			});
			obj.find(".decrease").click(function() {
				var n = $(this).parent().find('.num');
				n.val(parseInt(n.val()) - 1)
				if (parseInt(n.val()) < 0) {
					n.val(0);
				}
				setTotal();
			});
			obj.find('.num').blur(function(){
				setTotal();
			});

			//设置结算按钮的状态
			function setButton (){
				if(obj.find(".setSelectAll:checked").length > 0){
					obj.find('.btn-pay').removeClass('disabled');
				}else{
					obj.find('.btn-pay').addClass('disabled');
				}
			};
			function setTotal() {
				var quantity = 0;	//总数量
				var total = 0;		//总价格
				var len = obj.find('.checked').length;
				if(len <= 1){
					obj.find(".total b").html('￥0.00');
					obj.closest('.cart-list').find(".quantity b").html(0);
				}
				
				obj.find('.cart-box .checked').each(function(i){
					var number = $(this).find('.num').val();		//数量
					var price = $(this).find('.price .n').text();	//单价
					
					var th=obj.find('.icon-del')
					var id=$(th).attr('id');
					 for (i = 0; i < localStorage.length; i++) {
				            if (id == localStorage.key(i)) {
				                var data = localStorage.getItem(localStorage.key(i));
				                num = JSON.parse(data);
				                var localData = {
				                    intro:num.intro,
				                    number: number,
				                    price: num.price,
				                    id: num.id,
				                    imgurl: num.imgurl
				                }
				                localStorage.setItem(id, JSON.stringify(localData));
				            }
				        }
					
					
					
					total += parseInt(number) * parseFloat(price);
					quantity += parseInt(number);
					obj.find(".total b").html('￥' + total.toFixed(2));
					obj.find(".quantity b").html(quantity);
					if(quantity >= 1){
						obj.find('.btn-pay').removeClass('disabled');
					}else{
						obj.find('.btn-pay').addClass('disabled');
					}
				});
			}
			
			//结算
			obj.find('.btn-pay').click(function(){
				location.href='${pageContext.request.contextPath}/wx/payment'
			});
		});
		
	}


</script>
<script src="${pageContext.request.contextPath}/js/cart.js"></script>
</body>
</html>