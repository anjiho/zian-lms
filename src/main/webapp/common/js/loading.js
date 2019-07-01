/**
 * Modal Loading JavaScript Library
 * @author 						c
 * @date    					2017-11-06
 * @param  {window} 	global
 * @param  {jQuery} 	$
 * @param  {function} 	factory
 * @return {void}
 * @version 1.0.0
 */
(function(window, $, factory) {

    window.Loading = factory(window, $);

})(window, jQuery, function(window, $) {

    var windowWidth;
    var windowHeight;

    /**
     * �꾦�쟊oading
     * @author  				c
     * @date 					2017-11-06
     * @param {Object} options	�꾦�쟊oading�꾢끁鵝볟뢿��
     * @return {Loading} 		Loading野배괌
     */
    function Loading(options) {
        return new Loading.prototype._init($('body'), options);
    }

    /**
     * �앭쭓�뽩눦��
     * @author  				c
     * @date 					2017-11-06
     * @param {Object} $this	jQuery野배괌
     * @param {Object} options	�꾦�쟊oading�꾢끁鵝볟뢿��
     * @return {Loading} 		Loading野배괌
     */
    const init = Loading.prototype._init = function($target, options) {

        this.version = '1.0.0';

        this.$target = $target;

        this.set = $.extend(true, {}, this.set, options);

        this._build();

        return this;

    };

    /**
     * �꾢뻠Loading
     * @return {void}
     */
    Loading.prototype._build = function() {

        this.$modalMask = $('<div class="modal-mask"></div>');

        this.$modalLoading = $('<div class="modal-loading"></div>');

        this.$loadingTitle = $('<p class="loading-title"></p>');

        this.$loadingAnimation = $('<div class="loading-animate"></div>');

        this.$animationOrigin = $('<div class="animate-origin"><span></span></div>');

        this.$animationImage = $('<img/>');

        this.$loadingDiscription = $('<p class="loading-discription"></p>');

        // zIndex
        if(this.set.zIndex <= 0) {
            this.set.zIndex = (this.$target.siblings().length-1 || this.$target.children().siblings().length) + 10001;
        }

        // var attr, value;
        // for(attr in this.set) {
        // 	if(attr !== 'zIndex' && attr !== 'animationDuration') {
        // 		value = this.set[attr];
        // 		if(typeof value === 'number') {
        // 			if(value <= 0) {
        // 				this.set[attr] = 'auto';
        // 			} else {
        // 				this.set[attr] = (value + this.set.unit);
        // 			}
        // 		}
        // 	}
        // }

        // �꾢뻠Loading
        this._buildMask();

        this._buildLoading();

        this._buildTitle();

        this._buildLoadingAnimation();

        this._buildDiscription();

        // ��맔�앭쭓�뽬퓝
        this._init = false;

        if(this.set.defaultApply) {
            this.apply();
        }

    }

    /**
     * �꾢뻠Mask
     * @return {void}
     */
    Loading.prototype._buildMask = function() {

        // 倻귝옖訝띺�귞뵪��쉘掠�
        if(!this.set.mask) {
            this.$modalMask.css({
                position: 	'absolute',
                top: 		'-200%',
            });
            return ;
        }

        // ��쉘掠귝졆凉�
        this.$modalMask.css({
            backgroundColor: 	this.set.maskBgColor,
            zIndex: 			this.set.zIndex,
        });

        // 曆삣뒥窯앭쨼�꼊lass
        this.$modalMask.addClass(this.set.maskClassName);

    }

    /**
     * �꾢뻠Loading
     * @return {void}
     */
    Loading.prototype._buildLoading = function() {

        this.$modalLoading.css({
            width: 				this.set.loadingWidth,
            height: 			this.set.loadingHeight,
            padding: 			this.set.loadingPadding,
            backgroundColor: 	this.set.loadingBgColor,
            borderRadius: 		this.set.loadingBorderRadius,
        });

        // 躍껃��밧폀
        if(this.set.direction === 'hor') {
            this.$modalLoading.addClass('modal-hor-layout');
        }

        // 弱냡oading曆삣뒥�컈ask訝�
        this.$modalMask.append(this.$modalLoading);

    }

    /**
     * �꾢뻠Title
     * @return {void}
     */
    Loading.prototype._buildTitle = function() {

        if(!this.set.title) {
            return ;
        }


        this.$loadingTitle.css({
            color: 		this.set.titleColor,
            fontSize: 	this.set.titleFontSize,
        });

        this.$loadingTitle.addClass(this.set.titleClassName);

        this.$loadingTitle.text(this.set.title);

        // 弱냪itle曆삣뒥�컇oading訝�
        this.$modalLoading.append(this.$loadingTitle);

    }

    /**
     * �꾢뻠LoadingAnimation
     * @return {void}
     */
    Loading.prototype._buildLoadingAnimation = function() {

        // loadingAnimation
        this.$loadingAnimation.css({
            width: this.set.animationWidth,
            height: this.set.animationHeight,
        });

        if(this.set.loadingAnimation === 'origin') { // origin�①뵽
            this.$animationOrigin.children().css({
                width: this.set.animationOriginWidth,
                height: this.set.animationOriginHeight,
                backgroundColor: this.set.animationOriginColor,
            });
            for(var i = 0; i < 5; i++) {
                this.$loadingAnimation.append(this.$animationOrigin.clone());
            }
        } else if(this.set.loadingAnimation === 'image') { // �양뎴�좄슬�①뵽
            this.$animationImage.attr('src', this.set.animationSrc);
            this.$loadingAnimation.append(this.$animationImage);
        } //else {
        // 	throw new Error("[loadingAnimation] �귝빊�숃�. �귝빊�쇔룵�썰맏['origin', 'image']");
        // }

        this.$loadingAnimation.addClass(this.set.animationClassName);

        // 弱냡oadingAnimation曆삣뒥�컇oading訝�
        this.$modalLoading.append(this.$loadingAnimation);

    }

    /**
     * �꾢뻠Discription
     * @return {void}
     */
    Loading.prototype._buildDiscription = function() {

        if(!this.set.discription) {
            return ;
        }

        this.$loadingDiscription.css({
            color: 		this.set.discriptionColor,
            fontSize: 	this.set.discriptionFontSize,
        });

        this.$loadingDiscription.addClass(this.set.discriptionClassName);

        this.$loadingDiscription.text(this.set.discription);

        // 弱냪itle曆삣뒥�컇oading訝�
        this.$modalLoading.append(this.$loadingDiscription);

    }

    /**
     * 若싦퐤
     * @return {void}
     */
    Loading.prototype._position = function() {

        windowWidth = $(window).width();
        windowHeight = $(window).height();

        var loadingWidth = this.$modalLoading.outerWidth();
        var loadingHeight = this.$modalLoading.outerHeight();

        var x1 = windowWidth >>> 1;
        var x2 = loadingWidth >>> 1;
        var left = x1 - x2;

        var y1 = windowHeight >>> 1;
        var y2 = loadingHeight >>> 1;
        var top = y1 - y2;

        this.$modalLoading.css({ top, left });

    }

    /**
     * �ε콓瓦뉐벧�①뵽
     * @return {void}
     */
    Loading.prototype._transitionAnimationIn = function() {

        if(!this.set.animationIn) {
            this.$modalMask.css({ display: 'block' });
        } else {
            // this.$modalMask.removeClass(this.set.animationOut).addClass(this.set.animationIn);
            this.$modalMask.addClass(this.set.animationIn);
        }

    }

    /**
     * �뷴콓瓦뉐벧�①뵽
     * @return {void}
     */
    Loading.prototype._transitionAnimationOut = function() {


        if(!this.set.animationOut) {

            // this.$modalMask.css({ display: 'none' });
            this.$modalMask.remove();

        } else {

            this._timer && this._timer.clearTimeout(this._timer);

            this.$modalMask.removeClass(this.set.animationIn).addClass(this.set.animationOut);

            // this._timer = setTimeout(() => {
            // 	this.$modalMask.remove();
            // }, this.set.animationDuration);

            var self = this;

            this._timer = setTimeout(function() {
                self.$modalMask.remove();
            }, this.set.animationDuration);

        }
    }

    /**
     * �양ㅊLoading
     * @return {void}
     */
    Loading.prototype.apply = function() {
        this._transitionAnimationIn();

        // 瓦숁졆�됬릤瑥닷룾餓ε쥭�졿�㎬꺗, �졽맏訝띺�誤곦퍗�끻춼訝����_initLoading�방퀡.
        if(!this._init) {
            // �앭쭓�뻃oading
            this._initLoading();
        }

    }

    /**
     * �먫뿈Loading
     * @return {void}
     */
    Loading.prototype.out = function() {
        this._transitionAnimationOut();
    }

    /**
     * �앭쭓�뻃oading
     * @return {void}
     */
    Loading.prototype._initLoading = function() {

        // 藥꿰퍘�앭쭓瓦� �좈��띷А�앭쭓��
        if(this._init) {
            return ;
        }

        // 曆삣뒥�곈〉�㏘릎
        this.$target.append(this.$modalMask);

        // 若싦퐤
        this._position();

        // $(window).resize(() => {
        // 	windowWidth = $(window).width();
        // 	windowHeight = $(window).height();
        // 	this._position();
        // });

        var self = this;

        $(window).resize(function() {
            windowWidth = $(window).width();
            windowHeight = $(window).height();
            self._position();
        });

        this._init = true;
    }

    /**
     * Loading�귝빊掠욄��
     * ��빳嶸��뺟쉪溫양쉰訝�雅쌵ss�룟폀, 鸚띷쓡�꼊ss�룟폀��빳�싪퓝罌욃뒥class�ζ쎍�방졆凉�.
     *
     * �뤹킔�뺜퐤: 倻귝옖��춻寧╊림, �쇿렅�뉓�營�. 倻귝옖��빊耶쀧굳��, 容섋��뺜퐤訝�{unit}. zIndex�ㅵ쨼.
     *
     * 倻귝옖耶쀤퐪�룟폀訝틌ndefined(堊뗥쫩: titleFontFamily), �ｄ퉰弱녵폏�귞뵪�ⓨ��꾢춻鵝볠졆凉�(fontFamily)
     *
     * @author  c
     * @date 	2017-11-06
     * @version 1.0.0
     */
    Loading.prototype.set = {
        direction: 				'ver',	 					// �밧릲. ver: �귞쎍, hor: 麗닷뭄.

        title: 					undefined, 					// �뉔쥦�끻�.
        titleColor: 			'#FFF', 					// �뉔쥦�뉐춻窯쒑돯.
        titleFontSize: 			14, 						// �뉔쥦�뉐춻耶쀤퐪鸚㎩컦.
        titleClassName: 		undefined,					// �뉔쥦窯앭쨼�꼊lass��.
        // titleFontFamily: 	undefined,					// �뉔쥦耶쀤퐪�룟폀

        discription: 			undefined, 					// �뤺염�끻�.
        discriptionColor: 		'#FFF',						// �뤺염�뉐춻窯쒑돯.
        discriptionFontSize: 	14,							// �뤺염�뉐춻耶쀤퐪鸚㎩컦.
        discriptionClassName: 	undefined,					// �뤺염窯앭쨼�꼊lass��.
        // directionFontFamily: undefined,					// �뤺염耶쀤퐪�룟폀.

        loadingWidth: 			'auto',						// Loading若썲벧.
        loadingHeight: 			'auto',						// Loading遙섇벧.
        loadingPadding: 		20,							// Loading�낁씁瓮�.
        loadingBgColor: 		'#252525',					// Loading�뚧솺窯쒑돯.
        loadingBorderRadius: 	12,							// Loading�꼉orderRadius.
        // loadingPosition: 		'fixed',					// Loading�꼙osition

        mask: 					true, 						// ��쉘掠�. true: �양ㅊ��쉘掠�, false: 訝띷샑鹽�.
        maskBgColor: 			'rgba(0, 0, 0, .6)',		// ��쉘掠귟깒��쥪��.
        maskClassName: 			undefined,					// 訝븅겗營⒴콆曆삣뒥.
        // maskPosition: 			'fixed',					// ��쉘掠굋osition

        loadingAnimation: 		'origin',					// �좄슬�①뵽. origin: 烏①ㅊ鵝욜뵪容섋��꾢렅�밧뒯��, image: 烏①ㅊ鵝욜뵪�ゅ츣阿됧쎗�뉏퐳訝뷴뒥饔썲뒯��.
        animationSrc: 			undefined,					// �양뎴�좄슬�①뵽�꾢쑑��. (�띷룓: loadingAnimation=origin, 餓δ툔嶸�燁컊rigin�뽬�꿬mage)
        animationWidth: 		40, 						// �①뵽若썲벧. 訝튷mage�띈〃鹽뷴쎗�뉒쉪若썲벧.
        animationHeight: 		40,							// �①뵽遙섇벧. 訝튷mage�띈〃鹽뷴쎗�뉒쉪遙섇벧.
        animationOriginWidth:   4,							// �잏궧�①뵽若썲벧.    (�띷룓: origin)
        animationOriginHeight:  4,							// �잏궧�①뵽遙섇벧.    (�띷룓: origin)
        animationOriginColor:   '#FFF',						// �잏궧�①뵽�꾦쥪��.  (�띷룓: origin)
        animationClassName: 	undefined,					// 訝뷴뒯�삥렌�졽�訝ら쥫鸚뽫쉪class��.

        defaultApply: 			true,						// 容섋��ゅ뒯�양ㅊ.
        animationIn: 			'animated fadeIn', 			// �ε콓�①뵽.
        animationOut: 			'animated fadeOut',			// �뷴콓�①뵽.
        animationDuration: 		1000,						// �①뵽�곭뺌�띌뿴(�뺜퐤:ms)
        // fontFamily: 			'sans-serif',				// �뉐춻耶쀤퐪�룟폀.
        // position: 				'fixed',				// 若싦퐤. mask�똪oading�꾢츣鵝�.
        // unit: 				'px', 						// 溫양쉰容섋��뺜퐤.
        zIndex: 				0,							// ��鸚뽩쎍掠귞벨(mask). 倻귝옖��0�뽬�낁킓��, �쇾맏{$this.siblings() + 10001}.

    };

    init.prototype = Loading.prototype;

    return Loading;
});

function loadingOut(loading) {
    setTimeout(() => loading.out(), 1500);
}

function loadingOut2(loading) {
    setTimeout(() => loading.out(), 3000);
}
