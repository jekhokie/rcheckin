require 'spec_helper'

describe ConditionsController do
  before (:each) do
    @user = FactoryGirl.create :user_with_condition
    sign_in @user
  end

  describe "GET 'show'" do
    it "should find the correct the user" do
      get :show, :user_id => @user.id
      assigns(:user).should == @user
    end

    it "should find the correct condition" do
      get :show, :user_id => @user.id
      assigns(:condition).should == @user.condition
    end
  end
end
