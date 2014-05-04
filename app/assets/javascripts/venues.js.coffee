getParameterByName = (name) ->
  name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
  regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
  results = regex.exec(location.search)
  (if not results? then "" else decodeURIComponent(results[1].replace(/\+/g, " ")))
  

# SimpleDomObject is used for organizing event handlers
class SimpleDomObject
  
  constructor: ->
    # Bind event listeners
    @listen()

  listen: ->
    events = @events()

    for key of events
      try 
        f = @[key.split(/#(.+)?/)[0]] # event
        e = key.split(/#(.+)?/)[1] # target
        t = events[key] # function

        $('body').on e, t, f

      catch
        console.log "Unable to bind " + e + " event to " + t

### ** DOCUMENTATION **

  Class: CustomDropdownMenu
  Purpose: Create a custom dropdown menu from an existing select menu
  Parameters: 
    wrapper (required) : jQuery selector of dropdown wrapper
    defaultMsg (optional) : default message to be displayed 
    selectedIndex (optional) : which index is selected on page load

  HTML Markup
    <div class="cs-obj-dd">
      <select class="cs-obj-dd-sel">
        <option value="volvo">Volvo</option>
        <option value="saab">Saab</option>
        <option value="mercedes">Mercedes</option>
        <option value="audi">Audi</option>
      </select>
      <div class="cs-obj-dd-val dd-toggle"></div>
      <ul class="cs-obj-dd-opts"></ul>
    </div>
###
class CustomDropdownMenu extends SimpleDomObject
  
  constructor: (wrapper, defaultMsg, selectedIndex) ->
    
    # Change these values for defaults
    dm = "Choose one" # Default message
    si = -1 # Selected Index

    # initialize default values
    if typeof(selectedIndex) == 'undefined'
      @selectedIndex = si
    else 
      @selectedIndex = selectedIndex

    if typeof(defaultMsg) == 'undefined'
      @defaultMsg = dm
    else 
      @defaultMsg = defaultMsg

    @wrapper = wrapper 
    @dropdown = $(@wrapper).find('select')[0]
    @valContent = $(@wrapper + " .cs-obj-dd-val").children()
    @wrapperDOM = $(@wrapper)
    @initialize()

    super()

  events: =>
    'open#click' : @wrapper + ' .dd-toggle'
    'update#click' : @wrapper + ' .cs-obj-dd-opts .cs-obj-dd-opt'

  # Replicates the Select dropdown into the custom dropdown
  initialize: =>
    for option in @dropdown.options
      $(@wrapper + " .cs-obj-dd-opts").append(@_listItemMarkup(option.value, option.text))

    $(@wrapper + " .cs-obj-dd-val").text(@defaultMsg).append(@valContent)
    
  open: =>
    @wrapperDOM.toggleClass('open')

  # Update hidden select value, update visible selected value
  update: (e) =>
    li = $(e.currentTarget)
    @dropdown.selectedIndex = li.index() - 1
    $(@wrapper + " .cs-obj-dd-val").text(li.text()).append(@valContent)
    @wrapperDOM.removeClass('open')

  # Markup for list items
  _listItemMarkup: (val, text) ->
    return  [ "<li class='cs-obj-dd-opt' data-val='", val, "'>", text, "</li>"].join('')

  val: =>
    return @valContent

class AddToListDropdownMenu extends CustomDropdownMenu

  constructor: (wrapper, defaultMsg, selectedIndex) ->
    super(wrapper, defaultMsg, selectedIndex)

  events: ->
    $.extend super(), 
      # '_revertCreateField#blur' : ' #list-create input'
      '_keyupCreateField#keyup' : ' #list-create input'
      '_keyupCreateField#keyup' : ' #list-create input'
      'createList#submit' : '#create-new-list-form' 
      'createList#click' : '.add2' 
      'resetDropdown#click' : ' #cta-addtolist'

  initialize: =>
    super()
    # @wrapperDOM.find('.cs-obj-dd-opts').css('height', '0px')

  createList: (e) =>
    listName = $('#list-create').find('input').val()
    if listName != ""
      
      $.ajax(
        type: "POST"
        url: "/lists"
        dataType: "json"
        data: { list: { name: listName } }
      )
        .done (response) =>
          id = response.id
          name = response.name
          $(@wrapper).find('select').prepend('<option value="' + id + '">' + name + '</option>')
          $(@wrapper + " #list-create").after([ "<li class='cs-obj-dd-opt' data-val='", id, "'>", name, "</li>"].join(''))
          @_revertCreateField()
          $('.cs-obj-dd-opt[data-val="' + id + '"').click()
          $('.add-spinner').removeClass('visible')


    return false
         
  resetDropdown: =>
    $(@wrapper + " .cs-obj-dd-val").text(@defaultMsg).append(@valContent)


  open: =>

    if @wrapperDOM.hasClass('open')
      @wrapperDOM.css('height', '47px')
    else
      @wrapperDOM.css('height', 276 + "px")

    super()

  update: (e) =>
    if $(e.currentTarget).is $('#list-create')
      @_setCreateField()
    else
      if @wrapperDOM.hasClass('open')
        @wrapperDOM.css('height', '47px')
      super(e)

  _setCreateField: =>
    $('#list-create').addClass('focus').find('input').show().focus()
    @_keyupCreateField()

  _revertCreateField: (e) =>
    $('#list-create').removeClass('focus')
    $('#list-create').find('input').val('')

  _keyupCreateField: ->
    if $('#list-create').find('input').val() == ""
      $('#list-create').find('.add2').addClass('disabled')
    else
      $('#list-create').find('.add2').removeClass('disabled')

class AddToListModal extends SimpleDomObject
  constructor: (selector) ->
    @ddSelector = selector
    super()

  events: =>
    'addToList#click' : ' #cta-addtolist'

  addToList: =>
    
    listId = $(@ddSelector).get(0).value
    venueId = $(@ddSelector).data('venue-id')
    
    $.ajax(
      type: "PUT"
      url: "/lists/" + listId + "/add"
      data: { venue_id: venueId }
    )
      .done( (response) ->
        $("#flash-container").append("<div class='notice'>" + response.notice + "</div>")
        $('.md-close').click()
      )

    window.location.href = "#"

$(document).ready ->
  
  page_action = getParameterByName('page_action')
  if page_action
  	switch page_action
      when "submit-score-modal"
      	$("#submit-score-modal").addClass('visible')
      when "add_to_list"
      	$('#add_to_list').addClass('md-open')
      
  $("[data-open-modal]").click ->
  	$("#" + $(this).data('open-modal')).addClass('md-open')
  	
  $("body").on "click", ".fn-open-modal", (e) ->
    target = $(e.currentTarget).data('target-modal')
    pageAction = $(e.currentTarget).data('target-action')
    
    $("#" + target).addClass('visible')
    $("#user_page_action").get(0).value = pageAction

  $(".md-close").click ->
    $("#" + $(this).data('target-modal')).removeClass('md-open')

  new AddToListDropdownMenu('#list-dropdown', "Choose a list", -1)
  new AddToListModal('#list-select')
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



