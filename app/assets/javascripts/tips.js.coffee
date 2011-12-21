class Crowdscore.Views.TipListView extends Backbone.View
  el: "#tip_list"

  events:
    "click #sort-tips-recent": "sortByRecent"
    "click #sort-tips-popularity": "sortByPopularity"

  initialize: ->
    @sort = "recent"

  sortByRecent: (e) ->
    e.preventDefault()
    @updateTipSort "recent"

  sortByPopularity: (e) ->
    e.preventDefault()
    @updateTipSort "popularity"

  sortUrl: -> "#{location.href}/tips/sort?sort=#{@sort}"

  updateTipSort: (@sort) ->
    @updateSelectedFilter()
    $.get @sortUrl(), (data) => @$('#tips').html(data)

  updateSelectedFilter: ->
    @$('p.sort a').removeClass('selected')
    @$("p.sort a#sort-tips-#{@sort}").addClass('selected')
