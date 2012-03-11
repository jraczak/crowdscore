# Public: A view that displays all of the tags currently associated with 
# the venue and allows the user to add a new one.
#
# Examples
#
#   new CS.TagModalView(2) # 2 is the venue's id
class CS.TagModalView extends Backbone.View
  el: "#tag-modal"
  content_el: "#tag-modal .content"
  footer_el: "#tag-modal .modal-footer"

  events:
    "hide": "resetHash"
    "click #new_tag": "newTagForm"
    "click #done_with_tags": "hideModal"
    "submit .modal-footer form": "addTag"
    "click .modal-footer button.cancel": "resetFooter"
    "change select#tag_category_id": "updateTagIdDropdown"

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
    @setupTagDisplay()

  # Public: Pops up the modal dialog.
  displayModal: ->
    @$el.modal
      backdrop: true
      show: true

  # Public: Fetches the ListCollection for the current user.
  setupTagDisplay: ->
    @collection = new TagCollection
    @collection.setVenueId @id
    @setBindings()

    @collection.fetch()

  # Public: sets up the appropriate bindings for the association TagCollection.
  setBindings: ->
    @collection.bind 'reset', =>
      @renderTagCollection()
      @resetFooter()

  # Public: Renders all associated tags.
  renderTagCollection: =>
    if @collection.length > 0
      @$content_el.html JST['templates/tag_display'](tag_categories: @collection.byCategory())
    else
      @$content_el.html JST['templates/no_tags']()

  newTagForm: =>
    @allTags = new TagCollection
    @allTags.exclude @collection.pluck("id")
    @allTags.fetch
      success: =>
        @defaultFooter = @$footer.html()
        @$footer.html(JST['templates/add_tag_form'](venue_id: @id, tag_categories: @allTags.byCategory()))
        @$footer.find('input').focus()

    false

  updateTagIdDropdown: =>
    catId = parseInt( $('select#tag_category_id').val() )
    tags = @allTags.select (tag) => tag.categoryId() is catId && tag.get('id') not in @allTags.excluded_ids
    $('select#tag_id').html(JST['templates/tag_id_option'](tags: tags))

  addTag: (e) =>
    tag_id = $(e.target).find('#tag_id').val()
    @collection.addToVenue(tag_id)

    false

  resetFooter: =>
    @$footer.html(@defaultFooter)
    false

  hideModal: ->
    @$el.modal('hide')

  resetHash: ->
    location.hash = "#"
