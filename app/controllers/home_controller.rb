class HomeController < ApplicationController
  def index
    if user_signed_in?
      @users = User.all
    end
  end
end
