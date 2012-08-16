$ ->
  faye = new Faye.Client("http://localhost:9292/faye")
  faye.subscribe "/conditions/update", (data) ->
    user = JSON.parse(data).condition
    user_row = $("#co-users tbody tr[id='user_" + user.user_id + "'] td.state i")

    $(user_row).removeClass("state-star-out").addClass "state-star-in" if user.state is true
    $(user_row).removeClass("state-star-in").addClass "state-star-out" if user.state is false
