class DashboardPageModule
  constructor: -> 
    @wrapper = $('.recommendation-module')
    @right = $('.recommendation-module .module-right')
    @left = $('.recommendation-module .module-left')

    @listen()
    @ui.documentWidth = $(window).width()
    # @setHoverElements()
    
    $(window).resize (e) =>
      @ui.documentWidth = $(window).width()
      # @setHoverElements()

    @wrapper.on 'mouseover', @handleMouseOver
    @wrapper.on 'mouseout', @handleMouseOut
    @wrapper.on 'mousemove', @handleMouseOver

    @right.on 'click', @handleCarouselRight
    @left.on 'click', @handleCarouselLeft

  ui:
    documentWidth: undefined
    nextElement: undefined
    previousElement: undefined
    currentLeft: 0
    sensitivity: 100
    timeout: undefined
    direction: undefined
    replace: undefined

  listen: ->
    for key, func of @events
      try
        $(key.split(' ')[1]).on key.split(' ')[0], @[func]

      catch
        console.log "Unable to bind " + 
          key.split(' ')[0] + " event to " + 
          key.split(' ')[1]

  handleMouseOut: (e) =>
    $(e.currentTarget).removeClass('right').removeClass('left')

  handleMouseOver: (e) =>
    @ui.parentOffset = $(e.currentTarget).parent().offset();
    @ui.x = e.pageX - @ui.parentOffset.left
    @ui.y = e.pageY - @ui.parentOffset.top
    placement = @ui.documentWidth - @ui.x
    if placement < @ui.sensitivity
      $(e.currentTarget).addClass("right")
    else if @ui.x < @ui.sensitivity
      $(e.currentTarget).addClass("left")
    else
      @handleMouseOut(e)

  handleCarouselLeft: (e) =>
    @setStopElements(e, 'left').bind @
  
  handleCarouselRight: (e) =>
    @setStopElements(e, 'right').bind @

  showPagination: ->
    $(this).parent().css('margin-left', '-10px')

  setStopElements: (e, direction) ->
    cards = $(e.currentTarget).siblings('.recommendation-card').removeClass('gangster')
    for card in cards 
      pos = card.offsetLeft + card.offsetWidth 
      if pos > @ui.documentWidth
        $(card).addClass('gangster')
        $(e.currentTarget).closest('.recommendation-module-body').css('margin-left', '-' + pos + 'px')
        break    


$(document).ready ->
  # new DashboardPageModule()

# class DashboardPage

#   constructor: -> 
#     @listen()
#     @ui.documentWidth = $( window ).width()
#     $(window).resize (e) =>
#       @ui.documentWidth = $( window ).width()

#   listen: ->
#     for key, func of @events
#       try
#         $(key.split(' ')[1]).on key.split(' ')[0], @[func]

#       catch
#         console.log "Unable to bind " + 
#           key.split(' ')[0] + " event to " + 
#           key.split(' ')[1]

#   el: ".r_dashboard"

#   ui:   
#     documentWidth: 0
#     currentContainer: undefined
#     currentLeft: 0
#     x: 0
#     y: 0
#     speed: 0
#     sensitivity: 200
#     acceleration: 2
#     timeout: undefined
#     direction: undefined
#     replace: undefined


#   events: 
#     "mouseover .recommendation-module-body": "handleMouseOver"
#     "mouseout .recommendation-module-body": "stopSlideEvent"
#     "mousemove .recommendation-module-body": "handleMouseOver"
#     "resize window": "handleWindowResize"

#   handleWindowResize: (e) =>
#     alert ""

#   handleMouseOver: (e) =>
#     clearTimeout @ui.replaced if @ui.replaced
#     if @ui.currentContainer is undefined
#       @ui.currentContainer = $(e.currentTarget)

#     @ui.parentOffset = $(e.currentTarget).parent().offset();
#     @ui.x = e.pageX - @ui.parentOffset.left
#     @ui.y = e.pageY - @ui.parentOffset.top
#     @handleMousePosition(e)

#   handleMousePosition: (e) =>
#     placement = @ui.documentWidth - @ui.x
#     if placement < @ui.sensitivity
#       @ui.speed = ((@ui.sensitivity - placement) / @ui.sensitivity * @ui.acceleration)
#       @ui.direction = 'right'
#     else if @ui.x < @ui.sensitivity
#       @ui.direction = 'left'
#       @ui.speed = ((@ui.sensitivity - @ui.x) / @ui.sensitivity * @ui.acceleration)
#     else
#       @ui.speed = 0
    
#     clearTimeout @ui.timeout if @ui.timeout
    
#     @ui.timeout = setInterval( =>
#       @handleModulePosition(e)
#     , 0 )

#   handleModulePosition: (e) =>
#     if @ui.direction is 'right'
#       @ui.currentLeft = @ui.currentLeft + @ui.speed  
#     if @ui.direction is 'left'
#       @ui.currentLeft = @ui.currentLeft - @ui.speed
#     if 0 < @ui.currentLeft <= @ui.currentContainer.get(0).scrollWidth - @ui.documentWidth
#       @ui.currentContainer.css('margin-left', (-1 * @ui.currentLeft) + "px")
#     else 
#       clearTimeout @ui.timeout

#   stopSlideEvent: (e) => 
#     # @revertToOriginalPosition(@ui['currentContainer'])
#     @ui['currentContainer'] = undefined if @ui['currentContainer']
#     clearTimeout @ui.timeout

#   revertToOriginalPosition: (obj) =>
#     container = obj
#     left = parseFloat(container.css('margin-left'))
#     @ui.replaced = setInterval(=>
#       left = left + @ui.acceleration
#       if left <= 0 
#         container.css('margin-left', (left) + "px")
#       else 
#         clearTimeout @ui.replaced
#     , 0 )


# $(document).ready ->
#   new DashboardPage()