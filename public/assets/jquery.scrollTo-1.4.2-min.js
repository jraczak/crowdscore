/**
 * jQuery.ScrollTo - Easy element scrolling using jQuery.
 * Copyright (c) 2007-2009 Ariel Flesler - aflesler(at)gmail(dot)com | http://flesler.blogspot.com
 * Dual licensed under MIT and GPL.
 * Date: 5/25/2009
 * @author Ariel Flesler
 * @version 1.4.2
 *
 * http://flesler.blogspot.com/2007/10/jqueryscrollto.html
 */
!function(e){function t(e){return"object"==typeof e?e:{top:e,left:e}}var o=e.scrollTo=function(t,o,n){e(window).scrollTo(t,o,n)};o.defaults={axis:"xy",duration:parseFloat(e.fn.jquery)>=1.3?0:1},o.window=function(){return e(window)._scrollable()},e.fn._scrollable=function(){return this.map(function(){var t=this,o=!t.nodeName||-1!=e.inArray(t.nodeName.toLowerCase(),["iframe","#document","html","body"]);if(!o)return t;var n=(t.contentWindow||t).document||t.ownerDocument||t;return e.browser.safari||"BackCompat"==n.compatMode?n.body:n.documentElement})},e.fn.scrollTo=function(n,r,a){return"object"==typeof r&&(a=r,r=0),"function"==typeof a&&(a={onAfter:a}),"max"==n&&(n=9e9),a=e.extend({},o.defaults,a),r=r||a.speed||a.duration,a.queue=a.queue&&a.axis.length>1,a.queue&&(r/=2),a.offset=t(a.offset),a.over=t(a.over),this._scrollable().each(function(){function i(e){f.animate(l,r,a.easing,e&&function(){e.call(this,n,a)})}var s,c=this,f=e(c),u=n,l={},d=f.is("html,body");switch(typeof u){case"number":case"string":if(/^([+-]=)?\d+(\.\d+)?(px|%)?$/.test(u)){u=t(u);break}u=e(u,this);case"object":(u.is||u.style)&&(s=(u=e(u)).offset())}e.each(a.axis.split(""),function(e,t){var n="x"==t?"Left":"Top",r=n.toLowerCase(),m="scroll"+n,h=c[m],p=o.max(c,t);if(s)l[m]=s[r]+(d?0:h-f.offset()[r]),a.margin&&(l[m]-=parseInt(u.css("margin"+n))||0,l[m]-=parseInt(u.css("border"+n+"Width"))||0),l[m]+=a.offset[r]||0,a.over[r]&&(l[m]+=u["x"==t?"width":"height"]()*a.over[r]);else{var w=u[r];l[m]=w.slice&&"%"==w.slice(-1)?parseFloat(w)/100*p:w}/^\d+$/.test(l[m])&&(l[m]=l[m]<=0?0:Math.min(l[m],p)),!e&&a.queue&&(h!=l[m]&&i(a.onAfterFirst),delete l[m])}),i(a.onAfter)}).end()},o.max=function(t,o){var n="x"==o?"Width":"Height",r="scroll"+n;if(!e(t).is("html,body"))return t[r]-e(t)[n.toLowerCase()]();var a="client"+n,i=t.ownerDocument.documentElement,s=t.ownerDocument.body;return Math.max(i[r],s[r])-Math.min(i[a],s[a])}}(jQuery);