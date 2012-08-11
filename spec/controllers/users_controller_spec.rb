require 'spec_helper'

describe UsersController do
  before (:each) do
    @user = FactoryGirl.create :user_with_condition
    sign_in @user
  end

  describe "GET 'index'" do
    it "should return a list of users" do
      get :index, :id => @user.id
      assigns(:users).should_not be_nil
    end
  end

  describe "GET 'show'" do
    it "should return a user" do
      get :show, :id => @user.id
      assigns(:user).should_not be_nil
    end

    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end
  end
end
