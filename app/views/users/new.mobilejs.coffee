$("#content").html("<%= escape_javascript render(:file => 'users/new.mobile') %>").trigger "create"
