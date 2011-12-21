class Crowdscore.Views.Navigation extends View
  el: '.nav a.menu'

  render: =>
    $("body").click @closeMenu
    $('a.menu').click @toggleMenu

  closeMenu: (e) =>
    $(@el).parent('li').removeClass('open')

  toggleMenu: (e) ->
    $(@).parent('li').toggleClass('open')
    false

$ ->
  new Crowdscore.Views.Navigation
