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

$ ->
  $.Crowdscore = new Crowdscore
