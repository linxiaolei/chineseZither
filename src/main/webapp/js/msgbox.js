(function () {
    $.msgBox = {
        Alert:function (title,msg) {
            generateHtml("alert",title,msg);
            btnOk();  //alert只是弹出消息，因此没必要用到回调函数callback
            btnNo();
        },
        Confirm:function (title,msg,callback) {
            generateHtml("confirm",title,msg);
            btnOk(callback);
            btnNo();
        }
    }
    //生成Html
    var generateHtml = function (type,title,msg) {
        var _html = "";
        _html += '<div class="popMask"></div><div id="popBox"><span class="popTit">' + title + '</span>';
        _html += '<a class="popIco">x</a><div class="popMsg">' + msg + '</div><div class="btnBox">';
        if (type == "alert") {
            _html += '<input id="popBtnOk" type="button" value="确定" />';
        }
        if (type == "confirm") {
            _html += '<input id="popBtnNo" type="button" value="取消" />';
            _html += '<input id="popBtnOk" type="button" value="确定" />';
        }
        _html += '</div></div>';
        //必须先将_html添加到body，再设置Css样式
        $("body").append(_html); generateCss();
    }
    //生成Css
    var generateCss = function () {
        $(".popMask").css({position:'absolute',left:'0',top:'0',zIndex:'99999',width:'100%',height:'100%',filter:'Alpha(opacity=80)',opacity:'0.6',backgroundColor:'#000'});
        $("#popBox").css({position:'absolute',zIndex:'999999',width:'80%',maxWidth:'300px',borderRadius:'5px',backgroundColor:'#fff'});
        $(".popTit").css({display:'block',padding:'10px 15px',fontSize:'14px',borderRadius:'5px 5px 0 0',color:'#fff',backgroundColor:'#f15930',fontWeight:'bold'});
        $(".popMsg").css({lineHeight:'20px',padding:'20px',fontSize:'13px',borderBottom:'1px solid #ddd'});
        $(".popIco").css({display:'block',position:'absolute',right:'10px',top:'9px',width:'18px',height:'18px',lineHeight:'18px',textAlign:'center',cursor:'pointer',borderRadius:'18px',fontFamily:'helvetica',border:'1px solid #fff',color:'#fff'});
        $(".btnBox").css({margin:'15px 0 10px 0',textAlign:'center'});
        $("#popBtnOk,#popBtnNo").css({width:'85px',height:'30px',color:'#fff',border:'0',borderRadius:'0'});
        $("#popBtnOk").css({backgroundColor:'#f40'});
        $("#popBtnNo").css({backgroundColor:'#888',marginRight:'20px'});
        $("html").addClass('active-page');
        var _widht = document.documentElement.clientWidth;  //屏幕宽
        var _height = document.documentElement.clientHeight; //屏幕高
        var boxWidth = $("#popBox").width();
        var boxHeight = $("#popBox").height();
        //让提示框居中
        $("#popBox").css({top:(_height - boxHeight) / 2 + "px",left:(_widht - boxWidth) / 2 + "px"});
    }

    //确定按钮事件
    var btnOk = function (callback) {
        $("#popBtnOk").click(function () {
            $(".popMask,#popBox").remove();
            $("html").removeClass('active-page');
            if (typeof (callback) == 'function') {
                callback();
            }
       });
    }
    //取消按钮事件
    var btnNo = function () {
        $("#popBtnNo,.popIco").click(function () {
            $(".popMask,#popBox").remove();
            $("html").removeClass('active-page');
       });
    }
})();