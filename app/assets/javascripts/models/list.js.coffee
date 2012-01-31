class window.List extends Backbone.Model
  addVenue: (venue_id) ->
    $.post("#{@url()}/add", {venue_id: venue_id, "_method": 'put'}).success =>
      @fetch()

  removeVenue: (venue_id) ->
    $.post("#{@url()}/remove", {venue_id: venue_id, "_method": 'put'}).success =>
      @fetch()
