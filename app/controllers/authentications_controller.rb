class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, :except => [ :create, :new ]
  after_filter  :discard_flash

  protect_from_forgery :except => :create

  def new
    respond_to do |format|
      format.any(:js, :mobile, :mobilejs)
      format.html { render }
    end
  end

  def create
    auth_response = request.env['omniauth.auth']

    if auth_response
      @auth_hash = Hash.new

      if params[:provider] == "facebook"
        @auth_hash[:provider] = (auth_response['provider']      ? auth_response['provider']      : '')
        @auth_hash[:email]    = (auth_response['info']['email'] ? auth_response['info']['email'] : '')
        @auth_hash[:uid]      = (auth_response['uid']           ? auth_response['uid']           : '')
      elsif params[:provider] == "google"
        @auth_hash[:provider] = (auth_response['provider']      ? auth_response['provider']      : '')
        @auth_hash[:email]    = (auth_response['info']['email'] ? auth_response['info']['email'] : '')
        @auth_hash[:uid]      = (auth_response['uid']           ? auth_response['uid']           : '')
      elsif params[:provider] == "github"
        @auth_hash[:provider] = (auth_response['provider']      ? auth_response['provider']      : '')
        @auth_hash[:email]    = (auth_response['info']['email'] ? auth_response['info']['email'] : '')
        @auth_hash[:uid]      = (auth_response['extra']['raw_info']['id'] ? auth_response['extra']['raw_info']['id'].to_s : '')
      end

      # successful authentication
      unless @auth_hash[:provider].blank? or @auth_hash[:uid].blank?
        @authentication = Authentication.find_by_provider_and_uid(@auth_hash[:provider], @auth_hash[:uid])

        if user_signed_in?
          if @authentication # user is already signed in and used same service to sign in again
            flash[:notice] = "You are already signed in using #{@auth_hash[:provider].titleize}"
          else               # user has not yet added this authentication mechanism
            @authentication = current_user.authentications.create!(:provider => @auth_hash[:provider],
                                                                   :uid      => @auth_hash[:uid],
                                                                   :email    => @auth_hash[:email])
            flash[:notice] = "Your #{@auth_hash[:provider].titleize} account has been added as a sign-in mechanism"
          end

          @users = User.all

          session[:user_id]           = @authentication.user.id
          session[:authentication_id] = @authentication.id

          render "home/index"
        else
          if @authentication # existing user sign in
            session[:user_id]           = @authentication.user.id
            session[:authentication_id] = @authentication.id

            @users = User.all

            flash[:notice] = "Signed in successfully"
            render "home/index"
          else               # new user
            session[:auth_hash] = @auth_hash

            redirect_to :controller => :users, :action => :new
          end
        end
      else
        flash[:error] = "Error while authenticating via #{params[:provider].titleize} - invalid data"
        render "new"
      end
    else
      flash[:error] = "Error while authenticating with #{params[:provider].titleize} - invalid data"
      render "new"
    end
  end

  def signout
    if current_user
      session[:user_id] = nil
      session[:authentication_id] = nil

      session.delete :user_id
      session.delete :authentication_id

      flash[:notice] = "Signed out successfully"
    end

    session[:auth_hash] = nil
    session.delete :auth_hash

    render "home/index"
  end
end
