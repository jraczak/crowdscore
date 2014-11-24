prefixedEventListener = (element, type, callback) ->
  pfx = [
    "webkit"
    "moz"
    "MS"
    "o"
    ""
  ]

  p = 0

  while p < pfx.length
    type = type.toLowerCase()  unless pfx[p]
    element.addEventListener pfx[p] + type, callback, false
    p++
  return

# Necessary functions to have on every page
$(document).ready ->

  # Dismisses flash messages
  notices = $('#flash-container').children()
  for notice in notices
    prefixedEventListener notice, "AnimationEnd", (e) ->
      notice.remove()
    return