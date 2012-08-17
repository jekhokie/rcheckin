$ ->
  faye = new Faye.Client(fayeUrl + "/faye")
  faye.subscribe "/conditions/update", (data) ->
    user = JSON.parse(data).condition
    user_row = $("#co-users ul li[id='user_" + user.user_id + "']")

    if user.state is true
      $(user_row).removeClass("state-out").addClass "state-in"
      $(user_row).find("span.ui-icon").removeClass("ui-icon-delete").addClass "ui-icon-check"
    else if user.state is false
      $(user_row).removeClass("state-in").addClass "state-out"
      $(user_row).find("span.ui-icon").removeClass("ui-icon-check").addClass "ui-icon-delete"
