;(function($){
	$.fn.tab = function(options){
		var defaults = {};
		var opts= $.extend({},defaults,options);
		return this.each(function(){
			var obj = $(this);
			var headLi = obj.find(".tab-title li");
			var liIndex =0;
			var contLeft=0;
			var headLen = obj.find(".tab-title li").length;
			var tabCont = obj.find(".tab-content");
			var contItem = obj.find(".tab-content .tab-item");

			//设置宽度
			var headLiWidth = (100/headLen).toFixed(5);
			var contWidth = 100*headLen;
			var contItemWidth = (100/headLen).toFixed(5);
			headLi.eq(0).addClass('active');
			tabCont.children().eq(0).css('display','block');
			headLi.css("width",headLiWidth+"%");
			tabCont.css("width",contWidth+"%");
			contItem.css("width",contItemWidth+"%");

			//显示内容
			function showCont(index){
				tabCont.children().eq(index).css('display','block').siblings().css('display','none')
				// contLeft = -contItemWidth*index +"%";
				// tabCont.css({
				// 	"-webkit-transform":"translate("+ contLeft +")",
				// 	"-webkit-transition":"500ms linear",
				// 	"transform":"translate("+ contLeft +")",
				// 	"transition":"200ms linear"
				// });
				headLi.removeClass("active").eq(liIndex).addClass("active");
			}

			//点击滑出
			headLi.click(function(){
				liIndex = $(this).index();
				showCont(liIndex);
			});

			//向左滑动
			// tabCont.swipeLeft(function(){
			// 	liIndex++;
			// 	if(liIndex == headLen){
			// 		liIndex = 0;
			// 	}
			// 	showCont(liIndex);
			// });

			//向右滑动
			// tabCont.swipeRight(function(){
			// 	liIndex--;
			// 	if(liIndex <= -1){
			// 		liIndex = headLen -1;
			// 	}
			// 	showCont(liIndex);
			// });

		});
	}
})(Zepto);