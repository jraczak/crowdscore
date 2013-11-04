window.CS =
  Views: {}

  initialize: ->
    new CS.VenueSearchFormView if $("form#search").length
    new CS.VenueEditView if $("#new_venue").length
    new CS.VenueSearchView if $("#venue_list th.distance").length

    if $("#venue-detail").length
      new CS.VenueDetailRouter
      Backbone.history.start()

    getParameterByName = (name) ->
      name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]")
      regexS = "[\\?&]" + name + "=([^&#]*)"
      regex = new RegExp(regexS)
      results = regex.exec(window.location.href)

      return "" if results == null
      decodeURIComponent(results[1].replace(/\+/g, " "))

    autofocus = getParameterByName('autofocus')
    if autofocus
      $el = $("##{autofocus}")
      $.scrollTo("##{autofocus}")
      $el.focus()

$ ->
  CS.initialize()


  $('body').on "click", ".modal-background, .close-modal", ->
    $('.modal').removeClass "visible"
    $('.tmp-modal').removeClass('visible')
      
  $('#register').click ->
    $('#register-modal').addClass('visible')

  $('#login-button').click ->
    $('#login-modal').addClass('visible')

  $('[class*=button-show-]').click (e) ->
    $('.tmp-modal').addClass("visible")
    $('.modal').removeClass "visible"

    setTimeout -> 
      $("##{$(e.currentTarget).attr('class').replace('button-show-', '')}").addClass('visible')
    , 250
    
