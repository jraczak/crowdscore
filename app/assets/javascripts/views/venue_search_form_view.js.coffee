class CS.VenueSearchFormView extends Backbone.View
  el: "form#search"

  events:
    "click .current_location a": "useCurrentLocation"

  initialize: ->
    @render()

  render: ->
    @current_location = @$(".current_location")
    @showLink() if $.geolocation.support()

  showLink: ->
    @current_location.removeClass('hidden')

  hideLink: ->
    @current_location.addClass('hidden')

  useCurrentLocation: =>
    $.geolocation.find @setLocationInForm

  setLocationInForm: (location) =>
    @hideLink()

    @$('[name=latitude]').val(location.latitude)
    @$('[name=longitude]').val(location.longitude)
    @$('#zip').attr('placeholder', 'Using current location')
