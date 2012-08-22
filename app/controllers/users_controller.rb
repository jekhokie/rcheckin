class UsersController < ApplicationController
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
end
