class CS.VenueDetailRouter extends Backbone.Router
  routes:
    "lists": "lists"
    "tags": "tags"

  lists: ->
    id = @getVenueId()
    new CS.ListModalView(id: id)

  tags: ->
    id = @getVenueId()
    new CS.TagModalView(id: id)

  getVenueId: ->
    location.href.match(/\/venues\/(\d+)/)[1]
