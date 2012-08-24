require 'spec_helper'

describe ApplicationController do
  before do
    @user = FactoryGirl.create :user
  end

  describe "for a signed-in user" do
    before do
      session[:user_id] = @user.id
    end

    it "current_user should return the current user" do
      controller.send(:current_user).should == @user
    end

    it "user_signed_in? should return true" do
      controller.send(:user_signed_in?).should == 1
    end
  end

  describe "for a non signed-in user" do
    it "current_user should return nil" do
      controller.send(:current_user).should be_nil
    end

    it "user_signed_in? should return nil" do
      controller.send(:user_signed_in?).should be_nil
    end
  end
end
