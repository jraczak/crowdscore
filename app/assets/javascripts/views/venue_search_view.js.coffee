class CS.VenueSearchView extends Backbone.View
  el: "#results-list"

  headerCell: 'th.hidden.distance'
  distanceP: 'p.distance'

  initialize: -> @render()

  render: ->
    # Distances are hidden by default so that browsers without geolocation
    # will just ignore them.
    if $.geolocation.support()
      @calculateAndDisplayDistances()
      @showDistances()

  showDistances: ->
    @$(@headerCell).removeClass('hidden')
    @$(@distanceP).removeClass('hidden')

  calculateAndDisplayDistances: ->
    $(@distanceP).each (index, element) =>
      $.geolocation.find (location) =>
        @fillInDistance(location, @$(element))

  fillInDistance: (current_location, element) ->
    lat = parseFloat(element.data('lat'))
    long = parseFloat(element.data('long'))
    distance = Utils.calculateDistanceInMiles(lat, long, current_location.latitude, current_location.longitude)
    element.html("#{distance.toFixed(1)} miles")
