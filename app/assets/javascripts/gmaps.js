window.graphs = []
gangster = window.graphs;
function Gmap(data){
	this.data = data;
	this.bounds = new google.maps.LatLngBounds();
	this.initialize();
};

Gmap.prototype.addMapMarkers = function(){
	var self = this;
	var map = this.map;

	for(var i = 0; i < this.data.length; i++){
		this.createMarkerandInfoWindow(i);
	}

	map.fitBounds(this.bounds);
};

Gmap.prototype.createMarkerandInfoWindow = function(i){
	var position, marker, infoWindowContent;
	var self = this;

	position = new google.maps.LatLng(this.data[i].lat, this.data[i].lng);

	this.bounds.extend(position);

	marker = new google.maps.Marker({
		position: position,
		map: this.map
	});

	infoWindow = new google.maps.InfoWindow({
		content: this.data[i].description
	});

	google.maps.event.addListener(marker, 'click', function(){
		infoWindow.open(this.map, marker);
		var graph = self.createMarkerScoreGraph(infoWindow);
		gangster.push(graph)
	
	});
}

Gmap.prototype.createMarkerScoreGraph = function(infoWindow){
	var elem = $(infoWindow.content).find('canvas');

	var canvas = elem.get(0);
	var innerColor = elem.data('innercolor');
	var thickness = elem.data('thickness');
	var percent = elem.data('percent');
	var innerWhite = elem.data('innerwhite');
	var outterColor = elem.data('outtercolor');
	var graph = new ScoreGraph(canvas, innerColor, outterColor, percent, thickness, innerWhite);

	return graph
}

Gmap.prototype.animateMarkerScoreGraph = function(graph){
	graph.drawFullCircle();
	graph.drawPartialCircle();
}

Gmap.prototype.initialize = function(){
	var map_canvas = document.getElementById('search-results-map');

	var map_options = {
		center: new google.maps.LatLng(44.5403, -0.5463),
		zoom: 8,
		mapTypeId: google.maps.MapTypeId.ROADMAP
	}

	this.map = new google.maps.Map(map_canvas, map_options);
	this.addMapMarkers();
};