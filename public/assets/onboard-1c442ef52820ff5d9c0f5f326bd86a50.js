(function(){var t;t=function(){function t(){var t=this;this.city=null,this.state=null,this.subcategories=[],this.slide=0,this.slides=$(".onboard-cards .card"),this.moveCard=this.slides.parent().get(0),$(this.slides.get(this.slide)).addClass("active"),$(".card-location").click(function(e){return t.clickLocationCard(e)}),$(".card-nav .next").click(function(e){return t.clickNavButton(e)}),$(".card-nav .back").click(function(e){return t.clickNavButton(e)}),$("body").on("click",".card .tag-group .tag",function(e){return t.selectTag(e)})}return t.prototype.clickLocationCard=function(t){var e,s;return $(".card-location").removeClass("selected"),$(t.currentTarget).addClass("selected"),$(t.currentTarget).parent().find(".next").addClass("enabled"),e=$(t.currentTarget).data("val"),s=$(t.currentTarget).data("state"),this.city=e,this.state=s},t.prototype.clickNavButton=function(t){return this.slide=$(t.currentTarget).data("slide"),999===this.slide?this.completeOnboard():this.goToSlide(t)},t.prototype.completeOnboard=function(){var t=this;return $(".r_onboard").addClass("onboard-finished"),$(".page-wrapper").animate({scrollTop:0},"slow"),setTimeout(function(){var e,s,a,r,n,i;for($(".r_onboard").remove(),$(".hidden-dashboard").toggleClass("visible-dashboard"),e={venue_category_name:"restaurant",venue_subcategories:[],city:t.city,state:t.state},i=t.subcategories,r=0,n=i.length;n>r;r++)a=i[r],e.venue_subcategories.push(a);return s=$("#cu").data("id"),$.post("users/"+s+"/onboard_user",e),setTimeout(function(){var t,e;return t=$(".r_dashboard")[0],e=$(".container")[0],e.appendChild(t),$(".hidden-dashboard").remove()},1e3)},1e3)},t.prototype.selectTag=function(t){var e,s,a,r;return s=$(t.currentTarget),e=$(t.currentTarget).data("cat"),r=$(".step-status .tag-counter"),s.hasClass("green")?(a=this.subcategories.indexOf(e),a>-1&&this.subcategories.splice(a,1)):this.subcategories.push(e),s.toggleClass("green"),this.subcategories.length>=3?(s.parent().parent().find(".next").addClass("enabled"),r.parent().addClass("completed")):(r.parent().removeClass("completed"),r.html("0"+(3-this.subcategories.length)),s.parent().parent().find(".next").removeClass("enabled"))},t.prototype.goToSlide=function(t){var e,s,a,r,n,i;return a=$(this.slides.get(this.slide)),r=$(t.currentTarget),r.removeClass("enabled"),this.slides.removeClass("active"),a.addClass("active"),0===this.slide&&null!==this.state&&setTimeout(function(){return a.find(".next").addClass("enabled")},500),s=$(this.slides).parent().offset().left,e=$(this.slides.get(this.slide)).offset().left,n=e-s,i=-1*(e-s),this.moveCard.style["-webkit-transform"]="translateX("+i+"px)",this.moveCard.style["-moz-transform"]="translateX("+i+"px)",this.moveCard.style["-ms-transform"]="translateX("+i+"px)",this.moveCard.style["-o-transform"]="translateX("+i+"px)",this.moveCard.style.transform="translateX("+i+"px)"},t}(),$(document).ready(function(){return new t})}).call(this);