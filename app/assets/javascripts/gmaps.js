
function Gmap(data){
	this.data = data;
	this.markers = new Array();
	this.bounds = new google.maps.LatLngBounds();
	this.initialize();
	this.currentInfoWindow = null;
	this.setupSearchResultClickEvent();
};

Gmap.prototype.addMapMarkers = function(){
	var self = this;
	var map = this.map;

	for(var i = 0; i < this.data.length; i++){
		this.createMarkerandInfoWindow(i);
	}

	google.maps.event.addListener(map, 'zoom_changed', function() {
    zoomChangeBoundsListener = 
      google.maps.event.addListener(map, 'bounds_changed', function(event) {
        if (this.getZoom() > 15 && this.initialZoom == true) {
          // Change max/min zoom here
          this.setZoom(15);
          this.initialZoom = false;
        }
      google.maps.event.removeListener(zoomChangeBoundsListener);
    });
	});
	
	map.initialZoom = true;

	map.fitBounds(this.bounds);
};

Gmap.prototype.createMarkerandInfoWindow = function(i){
	var position, marker, infoWindowContent, percent, content, venueId, infoWindow;
	var self = this;

	position = new google.maps.LatLng(this.data[i].lat, this.data[i].lng);

	this.bounds.extend(position);

	marker = new google.maps.Marker({
		position: position,
		map: this.map
	});

	infoWindow = new google.maps.InfoWindow({
		content: this.data[i].description,
		pixelOffset: new google.maps.Size(-125, 180)
	});

	content = $(infoWindow.content).find('.pie-graph-loader');
	percent = content.data('percent');
	venueId = content.data('venue-id');

	self.markers.push({
		marker: marker,
		venueId: venueId,
		infoWindow: infoWindow,
		percent: percent
	});

	google.maps.event.addListener(marker, 'click', function(){
		self.openMapMarker(venueId)
	});
}

Gmap.prototype.openMapMarker = function(venueId){
	var elem = this.markers.filter(function(obj){return obj.venueId == venueId})
	elem = elem[0];

	if (this.currentInfoWindow)
		this.currentInfoWindow.close();

	this.currentInfoWindow = elem.infoWindow;
	elem.infoWindow.open(this.map, elem.marker);
	this.animateVenueInfoWindowGraph(elem.venueId, elem.percent);
	this.clearGoogleMarkup();
	this.updateSearchResultsBank(elem.venueId);
}
Gmap.prototype.clearGoogleMarkup = function() {
	var all = $('.gm-style .gm-style-iw');
	all.prev().remove();
	all.next().remove();
}

Gmap.prototype.animateVenueInfoWindowGraph = function(venueId, percent) {
	$("[data-venue-id=" + venueId + "][data-percent=" + percent + "]").addClass('animate-to-' + percent);
}

Gmap.prototype.updateSearchResultsBank = function(venueId) {
	$(".search-result").removeClass('active');
	$(".search-result[data-venue-id=" + venueId + "]").addClass('active');
}

Gmap.prototype.setupSearchResultClickEvent = function() {
	var self = this;
	$('body').on('click', '.search-result', function(){
		var venueId = $(this).data('venue-id');
		self.openMapMarker(venueId)
	});
}

Gmap.prototype.initialize = function(){
	var map_canvas = document.getElementById('search-results-map');

	var map_options = {
		zoom: 8,
		scrollwheel: false,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}

	this.map = new google.maps.Map(map_canvas, map_options);
	this.addMapMarkers();
};


function VenueMap(data) {
	this.data = data[0];
	this.bounds = new google.maps.LatLngBounds();
	// debugger
	this.initialize();
}

VenueMap.prototype.initialize = function(){
	var map_canvas = document.getElementById('venue-map');

	var map_options = {
		zoom: 8,
		scrollwheel: false,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}

	this.map = new google.maps.Map(map_canvas, map_options);
	this.addMapSettings();
};

VenueMap.prototype.addMapSettings = function(){
	var self = this;
	var map = this.map;

	this.createMarker();

	google.maps.event.addListener(map, 'zoom_changed', function() {
    zoomChangeBoundsListener = 
      google.maps.event.addListener(map, 'bounds_changed', function(event) {
        if (this.getZoom() > 15 && this.initialZoom == true) {
          // Change max/min zoom here
          this.setZoom(15);
          this.initialZoom = false;
        }
      google.maps.event.removeListener(zoomChangeBoundsListener);
    });
	});
	
	map.initialZoom = true;
	map.fitBounds(this.bounds);
};

VenueMap.prototype.createMarker = function(){
	var position, marker, infoWindowContent, percent, content, venueId, infoWindow;
	var self = this;

	position = new google.maps.LatLng(this.data.lat, this.data.lng);

	this.bounds.extend(position);

	marker = new google.maps.Marker({
		position: position,
		map: this.map
	});
}