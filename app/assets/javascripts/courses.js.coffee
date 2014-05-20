course_on_load = ->

  $('ul.sf-menu').superfish();

  ### Intiate Sublime video player (For page change) ###
  sublime.load()

  ### Based on the tag, select relevant Tutorials###
  $('.tag').click (event) ->
    self = $(this)
    currentTag = self.text()
    $('.tag').removeClass('active-tag')
    self.addClass('active-tag')
    if currentTag == 'All'
      console.log('aaaaa')
      $('.tag-item').show()
      return false
    $.each $('.tag-item'), (i) ->
      if $.inArray(currentTag, $(this).attr('data-tag').split(',')) >= 0
        $(this).show('blind')
      else
        $(this).hide('blind')

  ### Set dynamic video source ###
  $('.watch-now').click ->
    self = $(this)
    sublime.unprepare('video-player')
    $('.video-source').attr('src', self.attr('data-url'))
    $('.video-title').text(self.attr('data-header'))
    sublime.prepare('video-player')

  ### Token field for tag input ###
  $(".selectpicker").tokenfield
    autocomplete:
      source: (request, response) ->
        $.getJSON "/admin/tags", q: {name_cont: request.term}, (data) ->
          results = $.map(data, (tag) ->
           {'label': tag.name, 'value': tag.id}
          )
          response results

  ### Token field for tag input ###
  $(".selectpicker_nav").tokenfield
    limit: 1,
    autocomplete:
      source: (request, response) ->
        $.getJSON "/admin/tags", q: {name_cont: request.term}, (data) ->
          results = $.map(data, (tag) ->
           tag.name
          )
          response results

  if $('.selectpicker').length > 0
    $('.selectpicker').tokenfield('setTokens', JSON.parse($('.selectpicker').attr('data')))

  $('.animate').animate({'margin-left': '0px'});

  if $('.selectpicker_nav').val() == ''
    $("#sb-search .tokenfield").hide()

  $('.sb-icon-search').click (event)->
    if $("#sb-search .tokenfield").is(":visible")
      if $('.selectpicker_nav').val() == ''
        $("#sb-search .tokenfield").fadeOut()
      else
        $(this).closest("form").submit()
    else
      $("#sb-search .tokenfield").fadeIn()
      $('#search-tokenfield').focus()
      event.stopImmediatePropagation();

  $('#search-tokenfield').focusout ->
    $("#sb-search .tokenfield").fadeOut()

  ### When image is not available set default###
  $('.image-design').error ->
    $(this).attr('src', '/assets/no_image.gif')

### Load after document ready ###
$(document).ready course_on_load

### Load after page change (Because of rails4 turbo link)  ###
$(window).bind 'page:change', course_on_load
