window.Crowdscore =
  Models: {}
  Views: {}

class window.View
  el: -> console.log('This must be overridden')

  constructor: ->
    if $(@el).length
      @render()
