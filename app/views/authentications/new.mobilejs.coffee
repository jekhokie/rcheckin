$("#content").html("<%= escape_javascript render(:file => 'authentications/new.mobile' %>").trigger "create"
