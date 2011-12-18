# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Crowdscore
  constructor: ->
    @category_field = $('#new_venue #venue_venue_category_id')
    @subcategory_field = $('#new_venue #venue_venue_subcategory_id')
    @category_throbber = @category_field.next("img")

    @category_field.change @updateSubcategorySelect
    @category_field.trigger("change")

    @setDistances()
    if $.geolocation.support()
      $('.current_location').removeClass('hidden')
        .find('a').click =>
          @setLocationInForm($('form#search'))

  disableSelect: ->
    @subcategory_field.attr('disabled', 'disabled').addClass('disabled')

  enableSelect: ->
    @subcategory_field.removeAttr('disabled').removeClass('disabled')

  hideFieldIfNoOptions: ->
    # There is an empty option we're auto-inserting before this method is fired
    if @subcategory_field.find("option").length > 1
      @subcategory_field.parents(".clearfix").show()
    else
      @subcategory_field.parents(".clearfix").hide()

  updateSubcategorySelect: (e) =>
    element = $(e.target)

    @disableSelect()
    @subcategory_field.html('<option value></option')

    markup = '<option value="${id}">${name}</option>'
    cat_id = element.val()

    if cat_id != ""
      @category_throbber.show()
      $.get("/venue_categories/#{cat_id}/venue_subcategories.json")
      .success (data) =>
        $.tmpl(markup, data).appendTo(@subcategory_field)
        @enableSelect()
        @hideFieldIfNoOptions()
      .error(@hideFieldIfNoOptions)
      .complete(=> @category_throbber.hide())

    else
      @hideFieldIfNoOptions()

  setLocationInForm: (form) ->
    $.geolocation.find (location) ->
      form.find('[name=latitude]').val(location.latitude)
      form.find('[name=longitude]').val(location.longitude)
      form.find('#zip').attr('placeholder', 'Using current location')
      form.find('.current_location').hide()

  setDistances: ->
    if $.geolocation.support()
      $('#venue_list .distance').removeClass('hidden')
      $('#venue_list td.distance').each (index, element) =>
        $.geolocation.find (location) =>
          e = $(element)
          distance = @calculateDistanceInMiles(parseFloat(e.data('lat')), parseFloat(e.data('long')), location.latitude, location.longitude)
          # e.html("#{Math.round(distance * 10) / 10} miles")
          e.html("#{distance.toFixed(1)} miles")

  # Taken from http://stackoverflow.com/questions/27928/how-do-i-calculate-distance-between-two-latitude-longitude-points
  calculateDistanceInMiles: (lat1, lon1, lat2, lon2) ->
    R = 6371
    dLat = (lat2-lat1).toRad()
    dLon = (lon2-lon1).toRad() 
    a = Math.sin(dLat/2) * Math.sin(dLat/2) +
      Math.cos(lat1.toRad()) * Math.cos(lat2.toRad()) * 
      Math.sin(dLon/2) * Math.sin(dLon/2)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a))
    R * c * 0.6214

if typeof(Number.prototype.toRad) == "undefined"
  Number.prototype.toRad = ->
    this * Math.PI / 180

$ ->
  $.Crowdscore = new Crowdscore
