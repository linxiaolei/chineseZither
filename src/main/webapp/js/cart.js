;(function(){
	//编辑
	$(".cart-main").find('.cart-list').each(function() {
		var obj = $(this);
		console.log(obj);
		obj.find('.cart-edit').click(function() {
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
			var len = obj.find('.cart-box .cart-group').length;
			if( len <= 1){
				$(this).closest(".cart-list").remove();
			}else{
				$(this).closest(".cart-group").remove();
			}
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
			if(!$(this).hasClass('disabled')){
				$(this).addClass('disabled');
				// window.location='payment.html';
			}
		});
	});
})();
