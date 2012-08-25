class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [ :new, :create ]

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

  def create
    @user = User.new params[:user]

    if @user.save
      @user.authentications.create session[:auth_hash]
      session[:user_id] = @user.id

      @users = User.all

      flash[:message] = "Successfully registered"
      render "home/index"
    else
      flash[:error] = "There was an error registering"
      render "new"
    end
  end
end
