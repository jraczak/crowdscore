# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Crowdscore
  constructor: ->
    $('#new_venue #venue_venue_category_id').change @updateSubcategorySelect

  disableSelect: (field) ->
    field.attr('disabled', 'disabled').addClass('disabled')

  enableSelect: (field) ->
    field.removeAttr('disabled').removeClass('disabled')

  updateSubcategorySelect: (e) =>
    element = $(e.target)
    subcatField = $('#new_venue #venue_venue_subcategory_id')
    @disableSelect(subcatField)
    $.get "/venue_categories/#{element.attr('value')}/venue_subcategories.json", (data) =>
      markup = '<option value="${id}">${name}</option>'
      subcatField.html('<option value></option')
      $.tmpl(markup, data).appendTo(subcatField)
      @enableSelect(subcatField)

$ ->
  $.Crowdscore = new Crowdscore
