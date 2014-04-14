class window.List extends Backbone.Model
  addVenue: (venue_id) ->
    $.post("#{@url()}/add", {venue_id: venue_id, "_method": 'put'}).success =>
      @fetch()

  removeVenue: (venue_id) ->
    $.post("#{@url()}/remove", {venue_id: venue_id, "_method": 'put'}).success =>
      @fetch()

jQuery ->
  # List view page javascript
  if $("#list-header-container").length > 0 

    if $('#list-description').height() > 20 
      curpad = 1
      while $('#list-description').height() < 60
        $('#list-description').css('padding-left', curpad + "px")
        $('#list-description').css('padding-right', curpad + "px")
        curpad++
      $('#list-description').css('padding-left', (curpad - 15) + "px")
      $('#list-description').css('padding-right', (curpad - 15) + "px")
