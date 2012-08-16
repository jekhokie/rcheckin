$("#quick-stat").html("<%= escape_javascript(render(:partial => 'shared/quick_stat', :formats => [:mobile])) %>").trigger "create"

<% broadcast "/conditions/update" do %>
  <%= @condition.to_json(:only => [ :user_id, :state ]).html_safe %>
<% end %>
