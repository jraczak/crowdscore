class CS.VenueDetailRouter extends Backbone.Router
  routes:
    "lists": "lists"

  lists: ->
    id = @getVenueId()
    new CS.ListModalView(id: id)

  getVenueId: ->
    location.href.match(/\/venues\/(\d+)/)[1]
