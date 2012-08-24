require 'spec_helper'

describe AuthenticationsController do
  describe "GET 'new'" do
    it "should present the sign in page" do
      get :new
      response.should render_template("authentications/new")
    end
  end

  describe "POST 'create'" do
    before do
      @auth_hash = OmniAuth.config.mock_auth[:facebook]
      request.env["omniauth.auth"] = @auth_hash
    end

    describe "auth_hash" do
      before do
        post :create, :provider => @auth_hash["provider"]
      end

      it "should be created" do
        assigns(:auth_hash).should_not be_empty
      end

      it "should assign the provider" do
        assigns(:auth_hash)['provider'].should_not be_nil
      end

      it "should assign the uid" do
        assigns(:auth_hash)['uid'].should_not be_nil
      end

      it "should assign the email" do
        assigns(:auth_hash)['email'].should_not be_nil
      end
    end

    describe "for an existing user" do
      before do
        @authentication = FactoryGirl.create :authentication, :provider => @auth_hash["provider"],
                                                              :uid      => @auth_hash["uid"]
        @user = @authentication.user

        post :create, :provider => @auth_hash["provider"]
      end

      it "should assign the user id to the current session" do
        session[:user_id].should_not be_nil
        session[:user_id].should == @user.id
      end

      it "should assign the authentication id to the current session" do
        session[:authentication_id].should_not be_nil
        session[:authentication_id].should == @authentication.id
      end

      describe "that is signed in" do
        describe "for an unknown authentication source" do
          it "should prompt to add the new authentication source" do
            response.should render_template("authentications#edit")
          end

          it "should inform the user that the source is not known" do
            flash[:notice].should_not be_nil
            flash[:notice].should == "New authentication mechanism detected..."
          end
        end

        describe "for a known authentication source" do
          it "should inform the user that they are already signed in with the authentication source" do
            flash[:error].should_not be_nil
            flash[:error].should == "You are already signed in using Facebook"
          end
        end
      end

      describe "that is not signed in" do
        it "should display the home page" do
          response.should render_template("home/index")
        end

        it "should inform the user of successful sign in" do
          flash[:notice].should_not be_nil
          flash[:notice].should == "Signed in successfully"
        end
      end
    end

    describe "for a new user" do
      before do
        @authentication = FactoryGirl.create :authentication
        @user           = @authentication.user

        post :create, :provider => @auth_hash["provider"]
      end

      it "should allow the user to sign up" do
        response.should render_template("users/new")
      end
    end
  end
end
