require 'spec_helper'

describe AuthenticationsController do
  describe "GET 'new'" do
    before do
      get :new
    end

    it "should present the sign in page" do
      response.should render_template("authentications/new")
    end

    it "should assign the authentication providers" do
      assigns(:authentication_providers).should_not be_empty
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
      end

      it "should assign the user id to the current session" do
        post :create, :provider => @auth_hash["provider"]
        session[:user_id].should == @user.id
      end

      it "should assign the authentication id to the current session" do
        post :create, :provider => @auth_hash["provider"]
        session[:authentication_id].should == @authentication.id
      end

      describe "that is signed in" do
        before do
          session[:user_id] = @user.id
        end

        describe "for an unknown authentication source" do
          before do
            post :create, :provider => "bogus"
          end

          it "should inform the user that the source is not known" do
            flash[:error].should == "Error while authenticating via Bogus - invalid data"
          end
        end

        describe "for a known authentication source" do
          describe "not yet defined for the user" do
            before do
              @auth_hash = OmniAuth.config.mock_auth[:github]
              request.env["omniauth.auth"] = @auth_hash

              post :create, :provider => @auth_hash["provider"]
            end

            it "should assign a users variable" do
              assigns(:users).should_not be_nil
            end

            it "should assign the session user id" do
              session[:user_id].should_not be_nil
            end

            it "should assign the session authentication id" do
              session[:authentication_id].should_not be_nil
            end

            it "should inform the user that the source was added to available sign-in mechanisms" do
              flash[:notice].should == "Your Github account has been added as a sign-in mechanism"
            end
          end

          describe "already defined for the user" do
            before do
              post :create, :provider => @auth_hash["provider"]
            end

            it "should assign a users variable" do
              assigns(:users).should_not be_nil
            end

            it "should assign the session user id" do
              session[:user_id].should_not be_nil
            end

            it "should assign the session authentication id" do
              session[:authentication_id].should_not be_nil
            end

            it "should inform the user that they are already signed in with the authentication source" do
              flash[:notice].should == "You are already signed in using Facebook"
            end
          end
        end
      end

      describe "that is not signed in" do
        before do
          post :create, :provider => @auth_hash["provider"]
        end

        it "should assign a users variable" do
          assigns(:users).should_not be_nil
        end

        it "should assign the session user id" do
          session[:user_id].should_not be_nil
        end

        it "should assign the session authentication id" do
          session[:authentication_id].should_not be_nil
        end

        it "should display the home page" do
          response.should render_template("home/index")
        end

        it "should inform the user of successful sign in" do
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

      it "should assign the auth hash to the session variable" do
        session[:auth_hash].should_not be_empty
      end

      it "should allow the user to sign up" do
        response.should redirect_to(new_user_path)
      end
    end
  end
end
