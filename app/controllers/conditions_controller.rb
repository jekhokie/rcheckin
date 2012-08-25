class ConditionsController < ApplicationController
  before_filter :authenticate_user!, :find_user

  def show
    @condition = @user.condition

    respond_to do |format|
      format.any(:js, :mobile, :mobilejs)
      format.html { render :json => @condition }
    end
  end

  def update
    @user.condition.update_attributes params[:condition]
    @condition = @user.condition

    respond_to do |format|
      format.any(:js, :mobile, :mobilejs)
      format.html { render :json => @condition }
    end
  end

  private
  def find_user
    @user = User.find(params[:user_id])
  end
end
