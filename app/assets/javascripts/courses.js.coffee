course_on_load = ->

  ### Intiate Sublime video player (For page change) ###
  sublime.load()


### Load after document ready ###
$(document).ready course_on_load

### Load after page change (Because of rails4 turbo link)  ###
$(window).bind 'page:change', course_on_load
