class window.TagCollection extends Backbone.Collection
  url: -> if @venueId? then "/venues/#{@venueId}/tags.json" else "/venue_tags.json"
  model: Tag
  comparator: (tag) -> tag.get('name')

  setVenueId: (@venueId) ->

  exclude: (@excluded_ids) ->

  byCategory: ->
    cats = @reduce (categories, tag) =>
      if @excluded_ids?
        return categories if tag.get('id') in @excluded_ids

      name = tag.category()
      category = _.find categories, (cat) -> cat.name == name

      if category?
        category.tags.push tag
      else
        categories.push {
          name: name
          id: tag.categoryId()
          tags: [tag]
        }

      categories
    , []
    cats

  addToVenue: (id) =>
    $.post(@url(), {tag_id: id}).complete(=> @fetch())
