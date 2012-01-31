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

    $("#done_with_lists").live 'click', =>
      @$el.modal('hide')

    @$el.bind 'hide', ->
      location.hash = "#"

    @initializeModal()
    @resetListDisplay()

  initializeModal: ->
    @$el.modal
      backdrop: true
      show: true

  resetListDisplay: ->
    @model = new ListCollection
    @model.bind('reset', @renderList)

    @model.bind 'add', =>
      @renderList()
      @resetFooter()

    @model.fetch
      error: @renderSignupNotification

  renderList: =>
    @$content_el.html JST['templates/list_modal_instructions']()

    pickers = $.map(@model.models, @createListPicker)
    $.each pickers, (i, p) =>
      @$content_el.find("#pickers").append(p)

  createListPicker: (model) =>
    check = $("<input type='checkbox'/>")
    check.change(@addOrRemoveFromList)

    check[0].checked = true if model.get('venue_ids').indexOf(parseInt(@options.id)) > -1

    label = $("<label></label>").append(check, "&nbsp;", model.get('name'))

    $("<p></p>").data('cid', model.cid).append(label)

  addOrRemoveFromList: (e) =>
    $ele = $(e.target)
    $ele.attr(disabled: true)

    @model.bind 'change', =>
      $ele.attr(disabled: false)

    list = @model.getByCid($ele.parents('p').data('cid'))

    if $ele.attr('checked')
      list.addVenue(@id)
    else
      list.removeVenue(@id)

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
    name = $(e.target).find('#list_name').val()
    @model.create {list: {name: name, venue_ids: [@id]}}
    false

  resetFooter: =>
    @$footer.html(@defaultFooter)
    false
