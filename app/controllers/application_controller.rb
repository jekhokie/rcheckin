class ApplicationController < ActionController::Base
  before_filter :prepare_for_mobile

  protect_from_forgery

  private
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]

    # NOTE: Remove the conditionals on 'controller_name' when moving to another
    #       authentication source/mechanism. Not bothering to style mobile versions
    #       of devise since it should be going away soon.
    if controller_name != 'registrations' and controller_name != 'sessions'
      if mobile_device? and request.format.to_s == "text/html"
        request.format = :mobile
      elsif mobile_device? and request.format.to_s == "text/javascript"
        request.format = :mobilejs
      end
    end
  end
end
