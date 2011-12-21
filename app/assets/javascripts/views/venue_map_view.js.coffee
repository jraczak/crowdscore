class Crowdscore.Views.VenueMapView extends View
  el: "#map_canvas.venue-map"

  render: ->
    @element = $(@el)

    @setCoords()
    @initializeMap()
    @setMarker()

  setCoords: ->
    lat = @element.data('lat')
    long = @element.data('long')
    @location = new google.maps.LatLng(lat, long)

  initializeMap: ->
    @map = new google.maps.Map @element[0],
      zoom: 15
      center: @location
      disableDefaultUI: true
      zoomControl: true
      mapTypeId: google.maps.MapTypeId.ROADMAP

  setMarker: ->
    marker = new google.maps.Marker
      map: @map
      draggable: true

    marker.setPosition(@location)


$ -> new Crowdscore.Views.VenueMapView
