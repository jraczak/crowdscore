window.CS =
  Views: {}

  initialize: ->
    new CS.VenueSearchFormView if $("form#search").length
    new CS.VenueEditView if $("#new_venue").length
    new CS.VenueSearchView if $("#venue_list th.distance").length

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
