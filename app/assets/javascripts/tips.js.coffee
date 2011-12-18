# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

class Tip
  updateTipSort: (sort) ->
    $.get location.href + "/tips/sort?sort=#{sort}", (data) =>
      $('#tips').html(data)
      @updateSelectedFilter(sort)

  updateSelectedFilter: (sort) ->
    $('p.sort a').removeClass('selected')
    $("p.sort a#sort-tips-#{sort}").addClass('selected')

$.Tip = new Tip

$ ->
  $('#sort-tips-recent').click (e) ->
    e.preventDefault()
    $.Tip.updateTipSort('recent')

  $('#sort-tips-popularity').click (e) ->
    e.preventDefault()
    $.Tip.updateTipSort('popularity')
