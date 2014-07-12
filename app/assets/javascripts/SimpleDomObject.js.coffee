# SimpleDomObject is used for organizing event handlers
class window.SimpleDomObject
  
  constructor: (type) ->
    # Bind event listeners
    if type
      @listenOnElement()
    else
      @listenOnBody()

  listenOnBody: ->
    events = @events()

    for key of events
      try 
        f = @[key.split(/#(.+)?/)[0]] # event
        e = key.split(/#(.+)?/)[1] # target
        t = events[key] # function

        $('body').on e, t, f

      catch
        console.log "Unable to bind " + e + " event to " + t

  listenOnElement: ->
    events = @events()

    for key of events
      try 
        f = @[key.split(/#(.+)?/)[0]] # event
        e = key.split(/#(.+)?/)[1] # target
        t = events[key] # function

        $(e).on t, f

      catch
        console.log "Unable to bind " + e + " event to " + t
