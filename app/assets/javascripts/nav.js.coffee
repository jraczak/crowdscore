$ ->
  $("body").click (e) ->
    $('a.menu').parent('li').removeClass('open')

  $('a.menu').click (e) ->
    $(this).parent('li').toggleClass('open')
    false
