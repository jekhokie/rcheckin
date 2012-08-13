$("#quick-stat").html("<%= escape_javascript(render(:partial => 'shared/quick_stat', :formats => [:mobile])) %>").trigger "create"
