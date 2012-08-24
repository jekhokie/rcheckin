class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :prepare_for_mobile

  helper_method :mobile_device?
  helper_method :current_user
  helper_method :user_signed_in?

  private

  # Helper methods for mobile rendering
  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]

    if mobile_device? and request.format.to_s == "text/html"
      request.format = :mobile
    elsif mobile_device? and request.format.to_s == "text/javascript"
      request.format = :mobilejs
    end
  end

  # Helper methods for OmniAuth
  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    return 1 if current_user
  end

  def authenticate_user!
    if !current_user
      flash[:error] = "You need to sign in to view this page"
      redirect_to signin_path
    end
  end
end
