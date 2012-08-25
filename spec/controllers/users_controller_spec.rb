require 'spec_helper'

describe UsersController do
  describe "GET 'index'" do
    before do
      authentication = FactoryGirl.create :authentication
      @user = authentication.user
      session[:user_id] = @user.id
    end

    it "should return a list of users" do
      get :index
      assigns(:users).should_not be_empty
    end
  end

  describe "GET 'show'" do
    before do
      authentication = FactoryGirl.create :authentication
      @user = authentication.user
      session[:user_id] = @user.id
    end

    it "should return a user" do
      get :show, :id => @user.id
      assigns(:user).should_not be_nil
    end

    it "should find the right user" do
      get :show, :id => @user.id
      assigns(:user).should == @user
    end
  end

  describe "GET 'new'" do
    before do
      @authentication = FactoryGirl.build :authentication

      session[:auth_hash] = { :provider => "facebook",
                              :uid      => @authentication.uid,
                              :email    => @authentication.email }
      get :new
    end

    it "should return a built user" do
      assigns(:user).should_not be_nil
    end

    it "should return the user's email assigned to provider email" do
      assigns(:user).email.should == @authentication.email
    end

    it "should render the new (registrations) page" do
      response.should render_template("users/new")
    end
  end
end
