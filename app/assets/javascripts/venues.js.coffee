
$(document).ready ->

  $('body').on 'click', '#gangster-daddy', ->
  	venueId = $(this).data('venue-id')
  	scoreData = [
  		[1,10],
  		[2,10],
  		[3,10],
  		[4,10]
  	]
  	scoreData = JSON.stringify(scoreData)
  	console.log scoreData
  	$.ajax(
  	  type: "POST"
  	  url: "/venues/#{venueId}/score"
  	  dataType: "script"
  	  data: { score_data: scoreData }
  	)
  	  	
  $('.submit-score-continue, .submit-score-back').click ->
    progressPositions = 
    switch $(this).data('slide-set')
      when 1 
        carousel = $('#submit-score-flow')
        buttonSlide = 0
      when 2 
        carousel = $('#submit-score-form-carousel')
        buttonSlide = $(this).data('slide')
    slide = $(this).data('slide')

    left = "-" + ( slide * 100 ) + "%"
    carousel.css('left', left)
    $('#submit-score-form-carousel-buttons li').removeClass('active')
    $('#submit-score-form-carousel-buttons li[data-button-slide=' + buttonSlide + ']').addClass('active')
    $('.progress-bar-overlay-wrapper').css('width', "" + (buttonSlide * 66 + 38) + "px")

  $('select[id*="venue_score"]').each ->
    select = $(this)
    parent = $(this).siblings()[2]
    slider = $(parent).children('.ui-slider').slider
      range: "min"
      value: 1
      min: 1
      step: 1
      max: 10

      slide: (event, ui) =>
        select[0].selectedIndex = ui.value - 1;
        $(parent).children('.slider-bar-main-background').css("width", "" + ((this.selectedIndex + 1) * 10 - 5) + "%")
        if this.selectedIndex + 1 is 10
          $(parent).children('.slider-bar-main-background').css("width", "100%")
        $(parent).find('.marker-value').html( this.selectedIndex + 1 )
    select.change =>
      slider.slider('value', this.selectedIndex + 1 )
      $(parent).children('.slider-bar-main-background').css("width", "" + ((this.selectedIndex + 1) * 10 - 5) + "%")
      if this.selectedIndex + 1 is 10
        $(parent).children('.slider-bar-main-background').css("width", "100%")
      $(parent).find('.marker-value').html( this.selectedIndex + 1 )
  # for uiw in $('.ui-slider')
  #   select = $("#venue_score_score" + (_i + 1))
  #   select[0].selectedIndex = 0;
  #   slider = $(uiw)
  #   slider['field'] = slider.data('field')
  #   slider.slider
  #     range: "min"
  #     value: 1
  #     min: 1
  #     step: 1
  #     max: 10

  #     slide: (event, ui) =>
  #       select[0].selectedIndex = ui.value - 1;
  #       console.log slider['field']
  #       $('.slider-bar-main-background[data-field='+ slider['field'] +'').css("width", "" + (ui.value * 10 - 5) + "%")
  #       if ui.value is 10
  #         $('.slider-bar-main-background[data-field='+ slider['field'] +'').css("width", "100%")
  #       $('.marker-value').html(ui.value)

  #   select.change ->
  #     $(".ui-slider").slider( "value", this.selectedIndex + 1 )
  #     $('.slider-bar-main-background').css("width", "" + ((this.selectedIndex + 1) * 10 - 5) + "%")
  #     if this.selectedIndex + 1 is 10
  #       $('.slider-bar-main-background').css("width", "100%")
  #     $('.marker-value').html( this.selectedIndex + 1 )

