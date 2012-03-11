# Public: A view that displays a list of the current user's lists and 
# allows the association of a venue id to each one. Also allows the user 
# to create a new list on the fly.
#
# Examples
#
#   new CS.ListModalView(2) # 2 is the venue's id
class CS.ListModalView extends Backbone.View
  el: "#lists-modal"
  content_el: "#lists-modal .content"
  footer_el: "#lists-modal .modal-footer"

  events:
    "hide": "resetHash"
    "click #new_list": "newListForm"
    "click #done_with_lists": "hideModal"
    "submit .modal-footer form": "createList"
    "click .modal-footer button.cancel": "resetFooter"
    "click .modal-footer button.cancel": "resetFooter"
    "change .picker input": "addOrRemoveFromList"

  # Initializes the view and calls render. Note that a
  # venue id is explicitly required.
  initialize: ->
    unless @id?
      console.log("Must initialize with venue id.") 
      return false

    @$el = $(@el)
    @$content_el = $(@content_el)
    @$footer = $(@footer_el)

    @render()

  # Public: displays the modal dialog and sets up the list display.
  render: ->
    @displayModal()
    @setupListDisplay()

  # Public: Pops up the modal dialog.
  displayModal: ->
    @$el.modal
      backdrop: true
      show: true

  # Public: Fetches the ListCollection for the current user.
  setupListDisplay: ->
    @collection = new ListCollection
    @setBindings()

    @collection.fetch
      error: @renderSignupNotification

  # Public: sets up the appropriate bindings for the association ListCollection.
  setBindings: ->
    @collection.bind('reset', @renderListCollection)

    @collection.bind 'add', =>
      @renderListCollection()
      @resetFooter()

  # Public: Renders the list collection as a group of checkboxes. If this venue 
  # is already in the list, the checkbox will be checked.
  renderListCollection: =>
    @$content_el.html JST['templates/list_modal_instructions']()

    pickers = $.map(@collection.models, @createListPicker)
    $.each pickers, (i, p) =>
      @$content_el.find("#pickers").append(p)

  # Creates the HTML representation of a list picker (a checkbox) for a given 
  # list model.
  createListPicker: (model) =>
    checked = if parseInt(@id) in model.get('venue_ids') then ' checked="checked"' else ''

    JST['templates/list_picker']
      name: model.get('name')
      checked: checked
      id: model.get('id')

  # Change handler for a list picker checkbox. Determines if the list should be 
  # added as an association or not, then tells the model to adjust accordingly.
  addOrRemoveFromList: (e) =>
    $ele = $(e.target)
    id = parseInt($ele.parents('p').data('id'))
    console.log(id)
    list = @collection.find (list) -> id is parseInt(list.get('id'))

    if $ele.attr('checked')
      list.addVenue(@id)
    else
      list.removeVenue(@id)

  newListForm: =>
    @defaultFooter = @$footer.html()
    @$footer.html(JST['templates/new_list_form_for_modals'](venue_id: @id))
    @$footer.find('input').focus()

    false

  createList: (e) =>
    name = $(e.target).find('#list_name').val()
    @collection.create
      list:
        name: name
        venue_ids: [@id]

    false

  resetFooter: =>
    @$footer.html(@defaultFooter)
    false

  # Displays a fallback template -- displays a request to the user to sign in or 
  # sign up before they can use lists.
  renderSignupNotification: (data) =>
    @$content_el.html JST['templates/modal_signup_note'](location: location.href)

  hideModal: ->
    @$el.modal('hide')

  resetHash: ->
    location.hash = "#"
