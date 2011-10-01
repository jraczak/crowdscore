# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Crowdscore
  constructor: ->
    @subcategory_field = $('#new_venue #venue_venue_subcategory_id')
    $('#new_venue #venue_venue_category_id').change @updateSubcategorySelect
    $('#new_venue #venue_venue_category_id').trigger("change")

  disableSelect: (field) ->
    field.attr('disabled', 'disabled').addClass('disabled')

  enableSelect: (field) ->
    field.removeAttr('disabled').removeClass('disabled')

  hideFieldIfNoOptions: (field) ->
    # There is an empty option we're auto-inserting before this method is fired
    if field.find("option").length > 1
      field.parents(".clearfix").show()
    else
      field.parents(".clearfix").hide()

  updateSubcategorySelect: (e) =>
    element = $(e.target)
    subcatField = $('#new_venue #venue_venue_subcategory_id')
    @disableSelect(subcatField)
    markup = '<option value="${id}">${name}</option>'
    venueCategoryId = element.attr('value')
    subcatField.html('<option value></option')

    if venueCategoryId != ""
      $.get("/venue_categories/#{venueCategoryId}/venue_subcategories.json")
      .success (data) =>
        $.tmpl(markup, data).appendTo(subcatField)
        @enableSelect(subcatField)
        @hideFieldIfNoOptions(subcatField)
      .error (data) =>
        @hideFieldIfNoOptions(subcatField)
    else
      @hideFieldIfNoOptions(subcatField)

$ ->
  $.Crowdscore = new Crowdscore
