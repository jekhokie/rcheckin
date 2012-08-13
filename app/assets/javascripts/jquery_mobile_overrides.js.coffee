$(document).ready ->
  $("form").livequery ->
    $(this).attr "data-ajax", "false"

