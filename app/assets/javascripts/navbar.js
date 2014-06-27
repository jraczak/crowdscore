$(document).ready(function () {	
	$('.cs-h-search-trigger').click(function (e) {
		// $('.cs-h-inner').toggleClass('cs-h-push');

    if ($('.cs-h-inner').hasClass('cs-h-push')) {
      $('.cs-h-inner').removeClass('cs-h-push');
    } else {
      $('.cs-h-inner').addClass('cs-h-push');
    }

    $('.cs-h').click(function (e) {
      e.stopPropagation()
    });

		e.stopPropagation();
	});

  $('#cs-h-search-input').focus(function (e) {
    console.log(e)
  });

	$('body').click(function (e) {
		if ($('.cs-h-inner').hasClass('cs-h-push')) {
			$('.cs-h-inner').removeClass('cs-h-push');
		}
	});
});