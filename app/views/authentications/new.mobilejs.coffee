$("#content").html("<%= escape_javascript render(:file => 'authentications/new.mobile', :formats => [:mobile]) %>").trigger "create"
