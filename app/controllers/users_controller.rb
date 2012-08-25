class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [ :new ]

  def index
    @users = User.all

    respond_to do |format|
      format.any(:js, :mobile, :mobilejs)
      format.html { render :json => @users }
    end
  end

  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.any(:js, :mobile, :mobilejs)
      format.html { render :json => @user }
    end
  end

  def new
    @user = User.new :email => (session[:auth_hash][:email] ? session[:auth_hash][:email] : '')
  end
end
