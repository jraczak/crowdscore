class Crowdscore.Views.VenueView extends Backbone.View
  el: '#new_venue'

  events:
    "change #venue_venue_category_id": "updateSubcategorySelect"
    "cs:busy": "setBusyState"
    "cs:finished": "unsetBusyState"

  initialize: ->
    @category_field = @$('#venue_venue_category_id')
    @subcategory_field = @$('#venue_venue_subcategory_id')
    @category_throbber = @category_field.next("img")

    @category_field.trigger("change")

  setBusyState: (e) =>
    @disableSelect()
    @category_throbber.show()

  unsetBusyState: (e) =>
    @enableSelect()
    @category_throbber.hide()
    @hideFieldIfNoOptions()

  resetSubcategoryField: =>
    @subcategory_field.html('<option value></option')

  updateSubcategorySelectOptions: (data) =>
    @resetSubcategoryField()
    markup = '<option value="${id}">${name}</option>'
    $.tmpl(markup, data).appendTo(@subcategory_field)

  updateSubcategorySelect: (e) =>
    cat_id = @category_field.val()

    if cat_id != ""
      $(@el).trigger("cs:busy")
      $.get("/venue_categories/#{cat_id}/venue_subcategories.json")
        .success(@updateSubcategorySelectOptions)
        .complete(@unsetBusyState)
    else
      @hideFieldIfNoOptions()

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

$ ->
  new Crowdscore.Views.VenueView
