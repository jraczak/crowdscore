/* =========================================================
 * bootstrap-modal.js v1.3.0
 * http://twitter.github.com/bootstrap/javascript.html#modal
 * =========================================================
 * Copyright 2011 Twitter, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * ========================================================= */
!function(t){function i(i){function n(){o.$backdrop.remove(),o.$backdrop=null}var o=this,s=this.$element.hasClass("fade")?"fade":"";if(this.isShown&&this.settings.backdrop){var a=t.support.transition&&s;this.$backdrop=t('<div class="modal-backdrop '+s+'" />').appendTo(document.body),"static"!=this.settings.backdrop&&this.$backdrop.click(t.proxy(this.hide,this)),a&&this.$backdrop[0].offsetWidth,this.$backdrop.addClass("in"),a?this.$backdrop.one(e,i):i()}else!this.isShown&&this.$backdrop?(this.$backdrop.removeClass("in"),t.support.transition&&this.$element.hasClass("fade")?this.$backdrop.one(e,n):n()):i&&i()}function n(){var i=this;this.isShown&&this.settings.keyboard?t(document).bind("keyup.modal",function(t){27==t.which&&i.hide()}):this.isShown||t(document).unbind("keyup.modal")}var e;t(document).ready(function(){t.support.transition=function(){var t=document.body||document.documentElement,i=t.style,n=void 0!==i.transition||void 0!==i.WebkitTransition||void 0!==i.MozTransition||void 0!==i.MsTransition||void 0!==i.OTransition;return n}(),t.support.transition&&(e="TransitionEnd",t.browser.webkit?e="webkitTransitionEnd":t.browser.mozilla?e="transitionend":t.browser.opera&&(e="oTransitionEnd"))});var o=function(i,n){return this.settings=t.extend({},t.fn.modal.defaults,n),this.$element=t(i).delegate(".close","click.modal",t.proxy(this.hide,this)),this.settings.show&&this.show(),this};o.prototype={toggle:function(){return this[this.isShown?"hide":"show"]()},show:function(){var o=this;return this.isShown=!0,this.$element.trigger("show"),n.call(this),i.call(this,function(){var i=t.support.transition&&o.$element.hasClass("fade");o.$element.appendTo(document.body).show(),i&&o.$element[0].offsetWidth,o.$element.addClass("in"),i?o.$element.one(e,function(){o.$element.trigger("shown")}):o.$element.trigger("shown")}),this},hide:function(o){function s(){a.$element.hide().trigger("hidden"),i.call(a)}if(o&&o.preventDefault(),!this.isShown)return this;var a=this;return this.isShown=!1,n.call(this),this.$element.trigger("hide").removeClass("in"),t.support.transition&&this.$element.hasClass("fade")?this.$element.one(e,s):s(),this}},t.fn.modal=function(i){var n=this.data("modal");return n?i===!0?n:("string"==typeof i?n[i]():n&&n.toggle(),this):("string"==typeof i&&(i={show:/show|toggle/.test(i)}),this.each(function(){t(this).data("modal",new o(this,i))}))},t.fn.modal.Modal=o,t.fn.modal.defaults={backdrop:!1,keyboard:!1,show:!1},t(document).ready(function(){t("body").delegate("[data-controls-modal]","click",function(i){i.preventDefault();var n=t(this).data("show",!0);t("#"+n.attr("data-controls-modal")).modal(n.data())})})}(window.jQuery||window.ender);