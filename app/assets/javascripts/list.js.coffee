$(document).ready ->
	$('.toggle.delete').click (e) ->
		$('.confirm').toggleClass('visible')

	$('.keep').click (e) ->
		$('.confirm').removeClass('visible')

		
	$('.details:not(.edit) .toggle').click (e) ->
	 	$(this).parent().siblings('.edit-card').addClass('visible')
	 	$(this).parents('.list-card').addClass('edit')

	$('.button.cancel').click (e) ->
		$(this).parents('.edit-card').removeClass('visible')
		$(this).parents('.new-card').removeClass('visible')
		$(this).parents('.list-card').removeClass('edit')

	$('.new .create').click (e) ->
		$(this).parent().find('.new-card').addClass('visible')
		$(this).parents('.list-card').addClass('new')