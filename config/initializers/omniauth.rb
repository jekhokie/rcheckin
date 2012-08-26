Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
    provider :facebook, '340987179325654',        '6f18d1f0dde884d3a5cfc6acc2148cbc'
    provider :github,   'e5eaf39e03f435d77b17',   '403cb81282bde6690c94f8d8970a8da74a810275'
    provider :twitter,  'g2st6jYJoO8OGUX25nnyQ',  'pQnNZp5K3SyBCl9iiTChoHTJFM2tpceDcCB6VfaUk'
  else
    provider :facebook, '142995612507886',        '20fb59252d8210e4ffef168a233af8cf'
    provider :github,   '362d1578428434bf3242',   '260dd17b8c6647daa67b33364ded3f0c7dffc3cd'
    provider :twitter,  'rWHw9MNTSQiNZlmvMeVZjg', 'Zkc8z4gWUcWBjzvJeWvTQei9f1UFpFhOLgE53SyJs'
  end
end

module OmniAuth
  module Strategies
    class Facebook < OAuth2
      MOBILE_USER_AGENTS =  'webos|ipod|iphone|mobile'

      def request_phase
        options[:scope] ||= "email,offline_access"
        options[:display] = mobile_request? ? 'touch' : 'page'
        super
      end

      def mobile_request?
        ua = Rack::Request.new(@env).user_agent.to_s
        ua.downcase =~ Regexp.new(MOBILE_USER_AGENTS)
      end
    end
  end
end
