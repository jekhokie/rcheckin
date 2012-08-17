$("#quick-stat").replaceWith "<%= escape_javascript render(:partial => 'shared/quick_stat') %>"

<% broadcast "/conditions/update" do %>
  <%= @condition.to_json(:only => [ :user_id, :state ]).html_safe %>
<% end %>
