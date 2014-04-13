
$(document).ready ->

	$('body').on 'submit', '#new_venue_score', ->
		venueId = $(this).data('venue-id')
		scoreData = []

		for select in $('select[id*="venue_score"]')
			scoreData.push([$(select).data('scid'), select.selectedIndex + 1])

		console.log scoreData
		# scoreData = JSON.stringify(scoreData)
		# $.ajax(
		#   type: "POST"
		#   url: "/venues/#{venueId}/score"
		#   dataType: "script"
		#   data: { score_data: scoreData }
		# )
				
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
				index = ui.value - 1
				select.selectedIndex = index
				select[0].selectedIndex = index
				$(parent).children('.slider-bar-main-background').css("width", "" + ((select.selectedIndex + 1) * 10 - 5) + "%")
				if select.selectedIndex + 1 is 10
					$(parent).children('.slider-bar-main-background').css("width", "100%")
				$(parent).find('.marker-value').html( select.selectedIndex + 1 )
		select.change =>
			slider.slider('value', select.selectedIndex + 1 )
			$(parent).children('.slider-bar-main-background').css("width", "" + ((select.selectedIndex + 1) * 10 - 5) + "%")
			if select.selectedIndex + 1 is 10
				$(parent).children('.slider-bar-main-background').css("width", "100%")
			$(parent).find('.marker-value').html( select.selectedIndex + 1 )

