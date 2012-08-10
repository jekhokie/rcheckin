class ConditionsController < ApplicationController
  respond_to :js

  before_filter :find_user, :authenticate_user!

  def show
    respond_with @condition = @user.condition
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end
end
