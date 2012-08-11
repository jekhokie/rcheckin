class UsersController < ApplicationController
  respond_to :js

  before_filter :authenticate_user!

  def index
    respond_with @users = User.all
  end

  def show
    respond_with @user = User.find(params[:id])
  end
end
