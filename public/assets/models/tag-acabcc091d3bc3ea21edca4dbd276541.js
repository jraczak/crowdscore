(function(){var t,o={}.hasOwnProperty,r=function(t,r){function n(){this.constructor=t}for(var e in r)o.call(r,e)&&(t[e]=r[e]);return n.prototype=r.prototype,t.prototype=new n,t.__super__=r.prototype,t};window.Tag=function(o){function n(){return t=n.__super__.constructor.apply(this,arguments)}return r(n,o),n.prototype.category=function(){return this.get("tag_category").name},n.prototype.categoryId=function(){return this.get("tag_category").id},n}(Backbone.Model)}).call(this);