class HomeController < ApplicationController
  def index
    if user_signed_in?
      # initialize the condition of the user on first login
      if current_user.condition.blank?
        condition = Condition.create :state => 1

        current_user.condition = condition
        current_user.save!
      end

      @users = User.all
    end
  end
end
