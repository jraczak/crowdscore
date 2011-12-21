class Crowdscore.Views.VenueSearchFormView extends View
  el: "form#search"
  current_location_selector: ".current_location"

  render: ->
    @current_location = $(@current_location_selector)
    @showLink() if $.geolocation.support()

    @current_location.find('a').click @useCurrentLocation

  showLink: ->
    @current_location.removeClass('hidden')

  hideLink: ->
    @current_location.addClass('hidden')

  useCurrentLocation: =>
    $.geolocation.find @setLocationInForm

  setLocationInForm: (location) =>
    @hideLink()

    form = $(@el)
    form.find('[name=latitude]').val(location.latitude)
    form.find('[name=longitude]').val(location.longitude)
    form.find('#zip').attr('placeholder', 'Using current location')

$ ->
  new Crowdscore.Views.VenueSearchFormView
