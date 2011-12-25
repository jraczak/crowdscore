class CS.VenueMapView extends Backbone.View
  el: "#map_canvas.venue-map"

  initialize: ->
    @render()

  render: ->
    @$el = $(@el)
    @setCoords()
    @initializeMap()
    @setMarker()

  setCoords: ->
    lat = @$el.data('lat')
    long = @$el.data('long')
    @location = new google.maps.LatLng(lat, long)

  initializeMap: ->
    @map = new google.maps.Map @$el[0],
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
