class AuthenticationsController < ApplicationController
  def new
    @authentication_providers = [ "facebook" ]
  end

  def create
  end
end
