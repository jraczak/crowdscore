(function(){var t,e={}.hasOwnProperty,o=function(t,o){function r(){this.constructor=t}for(var n in o)e.call(o,n)&&(t[n]=o[n]);return r.prototype=o.prototype,t.prototype=new r,t.__super__=o.prototype,t};CS.VenueMapView=function(e){function r(){return t=r.__super__.constructor.apply(this,arguments)}return o(r,e),r.prototype.el="#map_canvas.venue-map",r.prototype.initialize=function(){return this.render()},r.prototype.render=function(){return this.$el=$(this.el),this.setCoords(),this.initializeMap(),this.setMarker()},r.prototype.setCoords=function(){var t,e;return t=this.$el.data("lat"),e=this.$el.data("long"),this.location=new google.maps.LatLng(t,e)},r.prototype.initializeMap=function(){return this.map=new google.maps.Map(this.$el[0],{zoom:15,center:this.location,disableDefaultUI:!0,zoomControl:!0,mapTypeId:google.maps.MapTypeId.ROADMAP})},r.prototype.setMarker=function(){var t;return t=new google.maps.Marker({map:this.map,draggable:!0}),t.setPosition(this.location)},r}(Backbone.View)}).call(this);