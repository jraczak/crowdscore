

select = $("#minbeds")
select[ 0 ].selectedIndex = 0;
$(".ui-slider").slider
  range: "min"
  value: 1
  min: 1
  step: 1
  max: 10
  slide: (event, ui) ->
    select[ 0 ].selectedIndex = ui.value - 1;
    $('.slider-bar-main-background').css("width", "" + (ui.value * 10 - 5) + "%")
    if ui.value is 10
      $('.slider-bar-main-background').css("width", "100%")
    $('#marker-value').html(ui.value)
$( "#minbeds" ).change ->
  $(".ui-slider").slider( "value", this.selectedIndex + 1 )
  $('.slider-bar-main-background').css("width", "" + ((this.selectedIndex + 1) * 10 - 5) + "%")
  if this.selectedIndex + 1 is 10
    $('.slider-bar-main-background').css("width", "100%")
  $('#marker-value').html( this.selectedIndex + 1 )