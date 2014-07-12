
defaultAvatarSrc = "http://fc04.deviantart.net/fs70/f/2013/076/0/f/square_avatar_by_ask_wolfprince-d5ybidu.png"
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

    avatar = @$el.find('.cs-h-user-nav img')
    avatar.error ->
      avatar.attr 'src', defaultAvatarSrc

  events: =>
    'showSearchView#click' : '.cs-h-search-trigger'
    'showSearchView#focus' : '#cs-h-search-input'
    'stopDefaultNavAction#click' : '.cs-h'
    'showDefaultView#click' : document
    'showLocationView#click' : '.cs-h-search-button'
    'showLocationView#focus' : '#cs-h-location-input'

  showDefaultView: =>
    if @$navInner.hasClass "cs-h-push"
      @$navInner.removeClass "cs-h-push"  

    if @$navInner.hasClass "cs-h-location"
      @$navInner.removeClass "cs-h-location" 

  showLocationView: =>
    @$navInner.addClass "cs-h-location"

  showSearchView: =>
    @$navInner.addClass "cs-h-push"

    if @$navInner.hasClass "cs-h-location"
      @$navInner.removeClass "cs-h-location" 

  stopDefaultNavAction: (e) ->
    e.stopPropagation()



$(document).ready ->
  navbar = new CrowdscoreHeader('element');
