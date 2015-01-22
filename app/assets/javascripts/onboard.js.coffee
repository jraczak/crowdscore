class Onboard

  constructor: -> 
    @city = null
    @state = null

    @subcategories = []
    @slide = 0
    @slides = $('.onboard-cards .card')
    @moveCard = @slides.parent().get(0)

    $(@slides.get(@slide)).addClass('active')
    $('.card-location').click (e) =>
      @clickLocationCard(e)

    $('.card-nav .next').click (e) =>
      @clickNavButton(e)

    $('.card-nav .back').click (e) =>
      @clickNavButton(e)

    $('body').on 'click', '.card .tag-group .tag', (e) =>
      @selectTag(e)

  clickLocationCard: (e) ->
    $('.card-location').removeClass('selected')
    $(e.currentTarget).addClass('selected')
    $(e.currentTarget).parent().find('.next').addClass('enabled')

    city = $(e.currentTarget).data('val')
    state = $(e.currentTarget).data('state')
    @city = city
    @state = state

  clickNavButton: (e) ->
    @slide = $(e.currentTarget).data("slide")
    if @slide == 999
      @completeOnboard()
    else
      @goToSlide(e)

  completeOnboard: ->
    
    $('.r_onboard').addClass('onboard-finished')
    $(".page-wrapper").animate({
     scrollTop: 0
     },"slow");
    setTimeout =>
      $('.r_onboard').remove()
      $('.hidden-dashboard').toggleClass('visible-dashboard')
      data = {
        venue_category_name: 'restaurant',
        venue_subcategories: [],
        city: @city,
        state: @state
      }

      for subcategory in @subcategories
        data.venue_subcategories.push subcategory
      id = $("#cu").data("id")
      $.post "users/#{id}/onboard_user", data 

      setTimeout ->
        inside = $('.r_dashboard')[0]
        outside = $('.container')[0]
        outside.appendChild(inside)
        $('.hidden-dashboard').remove()
      , 1000
    , 1000

  selectTag: (e) ->
    elem = $(e.currentTarget)
    cat = $(e.currentTarget).data('cat')
    tagCounter = $('.step-status .tag-counter')

    if elem.hasClass('green')
      index = @subcategories.indexOf(cat)
      if index > -1
        @subcategories.splice(index, 1)
    else
      @subcategories.push(cat)
    
    elem.toggleClass('green')

    if @subcategories.length >= 3
      elem.parent().parent().find('.next').addClass('enabled')
      tagCounter.parent().addClass('completed')
    else 
      tagCounter.parent().removeClass('completed')
      tagCounter.html("0" + (3 - @subcategories.length))
      elem.parent().parent().find('.next').removeClass('enabled')

  goToSlide: (e) ->
    finalSlide = $(@slides.get(@slide))
    next = $(e.currentTarget)
    next.removeClass('enabled')
    
    # Toggle Opacity
    @slides.removeClass('active')
    finalSlide.addClass('active')

    # Returning to original slide
    if @slide is 0 and @state != null
      setTimeout ->
        finalSlide.find('.next').addClass('enabled')
      , 500 

    containerLeft = $(@slides).parent().offset().left
    cardLeft = $(@slides.get(@slide)).offset().left
    offset = cardLeft - containerLeft

    position = -1 * (cardLeft - containerLeft)
    @moveCard.style["-webkit-transform"] = "translateX("+ position + "px)"
    @moveCard.style["-moz-transform"] = "translateX(" + position + "px)"
    @moveCard.style["-ms-transform"] = "translateX(" + position + "px)"
    @moveCard.style["-o-transform"] = "translateX(" + position  + "px)"
    @moveCard.style["transform"] = "translateX(" + position + "px)"


# cubic-bezier(0.755, 0.005, 0.400, 1.000)

$(document).ready ->
  new Onboard
