class HomeController < ApplicationController
  def index
    if user_signed_in?
      # initialize the condition of the user on first login
      if current_user.condition.blank?
        current_user.condition = Condition.new :state => 1
        current_user.save!
      end

      @users = User.all
    end
  end
end
