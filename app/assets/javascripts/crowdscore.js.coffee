window.CS =
  Views: {}

  initialize: ->
    new CS.VenueSearchFormView if $("form#search").length
    new CS.VenueEditView if $("#new_venue").length
    new CS.VenueSearchView if $("#venue_list th.distance").length

$ ->
  CS.initialize()
