course_on_load = ->

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

### Load after document ready ###
$(document).ready course_on_load

### Load after page change (Because of rails4 turbo link)  ###
$(window).bind 'page:change', course_on_load
