window.Crowdscore =
  Models: {}
  Views: {}

  initialize: ->
    new Crowdscore.Views.NavView

    new Crowdscore.Views.VenueMapView if $("#map_canvas.venue-map").length
    new Crowdscore.Views.VenueSearchFormView if $("form#search").length
    new Crowdscore.Views.VenueEditView if $("#new_venue").length
    new Crowdscore.Views.VenueSearchView if $("#venue_list th.distance").length

$ ->
  Crowdscore.initialize()
