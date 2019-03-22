$.fn.extend({
    ensureLoad: function(handler) {//개별 이미지 로드 완료 체크
        var $this = this;
        return (function (){
            return $this.each(function() {
                if(this.complete) {
                    handler.call(this);
                }else{
                    $(this).load(handler);
                    $this.onerror = function(){
                        handler.call(this, true);
                    }
                }
            });
        })();
    },
    imagesLoaded : function (fn, fn2) {
        var $imgs = this.find('img[src!=""]'), imgArr = {cpl : [], err : []};
        if (!$imgs.length){
            if(fn) fn();
            return;
        }
        var dfds = [], cnt = 0;
        $imgs.each(function(){
            var _this = this;
            var dfd = $.Deferred();
            dfds.push(dfd);
            var img = new Image();
            img.onload = function(){
                imgArr.cpl.push(_this);
                check();
            }
            img.onerror = function(){
                imgArr.err.push(_this);
                check();
            }
            img.src = this.src;
        });
        function check(){
            cnt++;
            if(cnt === $imgs.length){
                if(fn) fn.call(imgArr);
                if(imgArr.err && fn2) fn2.call(imgArr);
            }
        }
    }
});

/* imgAlign */
function imgAlign(obj, o){
    o = o || {};
    var divs;
    if (getClassType(obj) === 'Array'){
        obj.forEach( function(v) {
            divs = $(v);
            action($(v));
        });
    }else if (obj instanceof jQuery) (divs = obj, action(obj));
    else divs = $(obj); action($(obj));
    function getClassType(params){
        return Object.prototype.toString.call(params).slice(8,-1);
    }
    function action(ele){
        ele.each(function(){
            var img = $(this), bx = img.parent(), divAspect = bx.outerHeight() / bx.outerWidth();
            img.ensureLoad(function(){
                var imgAspect = img.outerHeight() / img.outerWidth();
                if (imgAspect <= divAspect) {
                    var imgWidthActual = bx.outerHeight() / imgAspect;
                    var marginLeft = -Math.round(((imgWidthActual/bx.outerWidth())-1) / 2 * 100000)/1000;
                    img.css({"margin-left":marginLeft+"%", "top":0, height: "100%"});
                } else {
                    var imgHeightActual = bx.outerWidth() * imgAspect;
                    var marginTop = -Math.round(((imgHeightActual/bx.outerHeight())-1) / 2 * 100000)/1000;
                    img.css({"top":marginTop+"%", "margin-left":0, "width": "100%"});
                }
                if(img.css('visibility') === 'hidden')img.css('visibility', 'visible');
            });
        });//each
    }
    if(o.resize){
        $(window).resize(action);
    }
}//imgAlign

var initPopup = function(t, params){//레이어 팝업 띄우는 공통 함수
    var defaults = {
        onStart : "",
        onClose : "",
        onLoad : "",
        btnCloseCl : 'btn-close',
        bgEle : '.bg-layer',
        resize : true,
        htmlOverHide: true,
        setScroll: true,
        showAfterImgLoad: false,
        hideByKey: true,
        hideByClickBg: true
    };
    params = params || {};
    for (var prop in defaults) {if (! (prop in params)) {params[prop] = defaults[prop];}}
    var html = $('html'), win = $(window), posi = t.css('position'), closeBtn;
    if(params.bgEle){
        if($("body > "+params.bgEle).length === 0){
            var bg_class = params.bgEle.replace("."," ");
            $("body").append($("<div></div>").addClass(bg_class));
        }
        var bg = $("body > "+params.bgEle).css('display','block');
        params.hideByClickBg && bg.on('click', hide);
    }
    t.css('display','');
    params.onStart && params.onStart(t);
    params.showAfterImgLoad ? imgLoad(show) : show();
    function hideByKey(e){
        if (e.keyCode === 27) hide();
    }
    function show(){
        if(params.resize) resize(), win.on('resize',resize);
        closeBtn = t.addClass('on').find('.'+params.btnCloseCl).on('click', hide);
        params.htmlOverHide && html.css('overflow','hidden');
        params.hideByKey && win.on('keyup', hideByKey);
        params.onLoad && params.onLoad(t);
    }
    function imgLoad(fn, fn2){
        var $imgs = t.find('img[src!=""]'), imgArr = {cpl : [], err : []};
        if (!$imgs.length) return fn && fn();
        var cnt = 0;
        $imgs.each(function(){
            var img = new Image();
            img.onload = function() {imgArr.cpl.push(this);check();};
            img.onerror = function() {imgArr.err.push(this);check();};
            img.src = this.src;
        });
        function check(){
            cnt++;
            if(cnt === $imgs.length){
                fn && fn();
                imgArr.err && fn2 && fn2();
            }
        }
    }
    function hide(){
        params.onClose ? params.onClose(t) : "";
        params.bgEle && bg.off('click').remove();
        closeBtn.off('click', hide);
        t.css('display','none');
        params.htmlOverHide && html.css('overflow','visible');
        win.off('resize',resize).off('keyup', hideByKey);
        return 0;
    }
    function resize(){
        var scl = posi === 'fixed' ? 0 : ((document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop);
        var vH = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        if (params.setScroll) t.css({ 'max-height': '' });
        var bxH = t.outerHeight();
        t.css({ "top": (bxH > vH ? scl : (vH - bxH) / 2 + scl) + "px" });
        if (params.setScroll) t.css({ 'max-height': vH });
    }
    return {closeFn : hide, ele: t};
};

function initAjaxPopup(o, popupOpt){
    var t = o.target ? $(o.target) : $("body");
    o.data = o.data || {};
    $.ajax({
        url : o.url,
        type : o.type || "get",
        dataType : "html",
        data : o.data,
        success : function(data){
            if(o.replace)t.html('');
            var popup = $(data);
            t.append(popup);
            initPopup(popup, popupOpt && Object.assign(popupOpt, {onClose : o.onClose || function(t){
                t.remove();
            }}));
        },
        error : function(a,b,c){
            alert(c);
        }
    })
}
