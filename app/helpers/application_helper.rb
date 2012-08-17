module ApplicationHelper
  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end

  def broadcast(channel, &block)
    message = { :channel => channel, :data => capture(&block), :ext => { :auth_token => FAYE_TOKEN } }
    uri = URI.parse("#{APP_CONFIG[:faye_url]}/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
  end
end
