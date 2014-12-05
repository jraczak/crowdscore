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

handleNoticeDismissal = (e) ->
  container = $(e.currentTarget)
  dismissNoticesAfterAnimation(container)

dismissNoticesAfterAnimation = (container) ->
  notices = container.children()
  for notice in notices
    prefixedEventListener notice, "AnimationEnd", ->
      notice.remove()

# Necessary functions to have on every page
$(document).ready =>
  dismissNoticesAfterAnimation $("#flash-container")
  $('#flash-container').on "DOMSubtreeModified", handleNoticeDismissal