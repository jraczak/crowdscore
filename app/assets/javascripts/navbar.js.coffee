
document.defaultAvatarSrc = "http://fc04.deviantart.net/fs70/f/2013/076/0/f/square_avatar_by_ask_wolfprince-d5ybidu.png"
class window.InputToTextMocker extends window.SimpleDomObject

  constructor: (@inputSelector, @textSelector) ->
    @$input = $(@inputSelector)
    @$text = $(@textSelector).find('p')
    super()

  events: =>
    'updateText#input': @inputSelector

  updateText: (e) =>
    val = $(e.currentTarget).val()
    @$text.text(val)
    @adjustInputWidth()

  adjustInputWidth: =>
    outerWidth = @$text.outerWidth()
    if outerWidth > 400
      @$input.css('width', (outerWidth + 5) + "px")
    else
      @$input.css('width', "400px")

class CrowdscoreHeader extends SimpleDomObject
  el: ".cs-h"

  constructor: ->
    @$el = $(@el)
    @$navInner = @$el.find('.cs-h-inner')
    @$searchInput = @$el.find('#cs-h-search-input')
    @$searchInputPlaceholder = @$el.find('#cs-h-search-input-placeholder')
    @initialize()
    super()

  initialize: =>
    new InputToTextMocker('#cs-h-search-input', '#cs-h-search-input-placeholder')

  events: =>
    'showSearchView#click' : '.cs-h-search-trigger'
    'showSearchView#focus' : '#cs-h-search-input'
    'stopDefaultNavAction#click' : '.cs-h'
    'showDefaultView#click' : document
    'showLocationViewFromEnter#keydown' : '#cs-h-search-input'
    'showLocationView#click' : '.cs-h-search-button'
    'showLocationView#focus' : '#cs-h-location-input'
    'stopSearchQuery#click' : '.cs-h-push:not(.cs-h-location) button.cs-h-search-button'

  showDefaultView: =>
    if @$navInner.hasClass "cs-h-push"
      @$navInner.removeClass "cs-h-push"  

    if @$navInner.hasClass "cs-h-location"
      @$navInner.removeClass "cs-h-location" 

    $('input').blur()

  stopSearchQuery: (e) =>
    e.stopPropagation()
    e.preventDefault()
    return false

  showLocationViewFromEnter: (e) =>
    if e.keyCode == 13
      @$navInner.addClass 'cs-h-location'
      @$navInner.find('#cs-h-location-input').focus()
      @stopSearchQuery(e)

  showLocationView: (e) =>
    @$navInner.addClass "cs-h-location"

  showSearchView: =>
    input = @$navInner.find('#cs-h-search-input')
    @$navInner.addClass "cs-h-push"
    if document.activeElement != $('#cs-h-search-input').get(0)
      $('#cs-h-search-input').focus()

    if @$navInner.hasClass "cs-h-location"
      @$navInner.removeClass "cs-h-location" 

  stopDefaultNavAction: (e) ->
    e.stopPropagation()



$(document).ready ->
  navbar = new CrowdscoreHeader('element');
