
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
    @$searchInput.focus()

    if @$navInner.hasClass "cs-h-location"
      @$navInner.removeClass "cs-h-location" 

  stopDefaultNavAction: (e) ->
    e.stopPropagation()



$(document).ready ->
  navbar = new CrowdscoreHeader('element');
