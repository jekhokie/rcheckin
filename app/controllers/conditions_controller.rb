class ConditionsController < ApplicationController
  respond_to :js, :mobile

  before_filter :find_user, :authenticate_user!

  def show
    respond_with @condition = @user.condition
  end

  def update
    @user.condition.update_attributes params[:condition]

    respond_with @condition = @user.condition
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end
end
