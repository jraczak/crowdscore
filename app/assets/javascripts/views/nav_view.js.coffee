class CS.NavView extends Backbone.View
  el: '.nav a.menu'

  events:
    "click": "toggleMenu"

  initialize: -> @render()

  render: ->
    $("body").click @closeMenu

  closeMenu: =>
    $(@el).parent('li').removeClass('open')

  toggleMenu: ->
    $(@el).parent('li').toggleClass('open')
    false
