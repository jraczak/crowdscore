class CS.ListModalView extends Backbone.View
  el: "#lists-modal"
  content_el: "#lists-modal .content"
  footer_el: "#lists-modal .modal-footer"
  listsUrl: "/lists.json"

  events:
    "click #new_list": "newListForm"

  initialize: ->
    unless @options.id?
      console.log("Must initialize with venue id.") 
      return false

    @render()

  render: ->
    @$el = $(@el)
    @$content_el = $(@content_el)
    @$footer = $(@footer_el)

    @$el.bind 'hide', ->
      location.hash = "#"

    @initializeModal()
    @resetListDisplay()

  initializeModal: ->
    @$el.modal
      backdrop: true
      show: true

  resetListDisplay: ->
    $.get(@listsUrl)
      .success(@renderList)
      .error(@renderSignupNotification)

  renderList: (data) =>
    @$content_el.html JST['templates/list_modal_instructions']()

    pickers = $.map(data, @createListPicker)
    $.each pickers, (i, p) =>
      @$content_el.find("#pickers").append(p)

  createListPicker: (json) =>
    check = $("<input type='checkbox'/>")
    check.change(@addOrRemoveFromList)

    check[0].checked = true if json.venue_ids.indexOf(parseInt(@options.id)) > -1

    label = $("<label></label>").append(check, "&nbsp;", json.name)

    $("<p></p>").data('id', json.id).append(label)

  addOrRemoveFromList: (e) =>
    $ele = $(e.target)
    $ele.attr(disabled: true)

    list_id = $ele.parents('p').data('id')
    url = "/lists/#{list_id}/"

    if $ele.attr('checked')
      url += "add"
    else
      url += "remove"

    $.post(url, {venue_id: @options.id, "_method": 'put'}).complete =>
      $ele.attr(disabled: false)
      # TODO: We're not currently doing any error checking here. That's probably a bad idea.


  renderSignupNotification: (data) =>
    @$content_el.html JST['templates/modal_signup_note'](location: location.href)

  newListForm: =>
    @defaultFooter = @$footer.html()
    @$footer.html(JST['templates/new_list_form_for_modals'](venue_id: @options.id))

    @$footer.find('form').submit(@createList)
    @$footer.find('button.cancel').click(@resetFooter)
    @$footer.find('input').focus()

    false

  createList: (e) =>
    form = $(e.target)
    $.post(form.attr('action'), form.serializeArray()).success =>
      @resetListDisplay()
      @resetFooter()

    false

   resetFooter: =>
     @$footer.html(@defaultFooter)
     false
