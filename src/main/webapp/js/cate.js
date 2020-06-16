Zepto(function(a) {
	var b = a("#scroll2"),
		c = a("#scroll1"),
		d = function() {
			var d = a(window).height() - 44;
			return d < c.height() && c.height(d).iScroll({
				hScroll: !1,
				useTransition: !0
			}), c.find(".cate-bg").height(d), b.height(d).iScroll({
				hScroll: !1,
				useTransition: !0,
				onScrollEnd: function() {
					a.fn.imglazyload.detect()
				}
			}), !0
		};
	if (a(window).on("ortchange resize", function() {
		var d = a(window).height() - 44;
		c.height(d).iScroll("refresh"), b.height(d).iScroll("refresh");
	}), d() && (a(".ui-imglazyload").imglazyload({
		container: b,
		extClass: "ware-img",
		innerScroll: !0
	}).on("loadcomplete", function() {
		b.iScroll("refresh")
	}), location.hash)) {
		var e = location.hash.substring(1, location.hash.length),
			f = a("#cate-" + e);
		if (f.length > 0) {
			var g = f.parent().find(".on"),
				h = g.removeClass("on").attr("catId");
			f.addClass("on"), c.iScroll("scrollToElement", f[0]), a("#sub-" + h).hide();
			var i = a("#sub-" + e);
			// i.find(".a-item").length > 0 ? (i.show(), b.iScroll("scrollTo", 0, 0).iScroll("refresh"), location.hash = e) : a("#nocontent").show() //带锚链
			i.find(".a-item").length > 0 ? (i.show(), b.iScroll("scrollTo", 0, 0).iScroll("refresh")) : a("#nocontent").show()
		}
	}
	a("#cate-menu").on(_def_click, "li", function() {
		var d = a(this).parent().find(".on"),
			e = d.removeClass("on").attr("catId"),
			f = a(this).addClass("on").attr("catId");
		c.iScroll("scrollToElement", this), a("#sub-" + e).hide();
		var g = a("#sub-" + f);
		// g.find(".a-item").length > 0 ? (g.show(), b.iScroll("scrollTo", 0, 0).iScroll("refresh"), location.hash = f) : a("#nocontent").show() //带锚链
		g.find(".a-item").length > 0 ? (g.show(), b.iScroll("scrollTo", 0, 0).iScroll("refresh")) : a("#nocontent").show()
	}), a(document).on("touchmove", function(a) {
		a.preventDefault()
	})
});var _def_click = "ontouchend" in document ? "tap" : "click";
