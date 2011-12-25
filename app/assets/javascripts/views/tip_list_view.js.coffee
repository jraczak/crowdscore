class CS.TipListView extends Backbone.View
  el: "#tip_list"

  events:
    "click #sort-tips-recent": "sortByRecent"
    "click #sort-tips-popularity": "sortByPopularity"

  initialize: ->
    console.log("ERROR: View must be initialized with a model") unless @model
    @model.bind('reset', @render)

  render: =>
    tips = @model.map (tip) -> JST['templates/tip'](tip: tip)
    @$('#tips').html(tips.join("\n"))

  sortByRecent: (e) ->
    e.preventDefault()
    @model.enableSortRecent()
    @updateSelectedFilter('recent')

  sortByPopularity: (e) ->
    e.preventDefault()
    @model.enableSortPopularity()
    @updateSelectedFilter('popularity')

  updateSelectedFilter: (sort) ->
    @$('p.sort a').removeClass('selected')
    @$("p.sort a#sort-tips-#{sort}").addClass('selected')
