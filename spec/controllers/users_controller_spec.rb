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

  describe "POST 'create'" do
    describe "with valid credentials" do
      before do
        @user = FactoryGirl.build :user
        session[:auth_hash] = @auth_params = FactoryGirl.attributes_for(:authentication)

        post :create, :user => @user.attributes
      end

      it "should assign a new user" do
        assigns(:user).should_not be_nil
      end

      it "should assign a valid user" do
        assigns(:user).should be_valid
      end

      it "should assign the user's email" do
        assigns(:user).email.should == @user.email
      end

      it "should assign the user's name" do
        assigns(:user).name.should == @user.name
      end

      it "should return a success message" do
        flash[:message].should_not be_empty
      end

      it "should render the home page" do
        response.should render_template("home/index")
      end

      it "should assign a list of users" do
        assigns(:users).should_not be_empty
      end

      describe "creates authentication record" do
        it "should create an authentication record" do
          assigns(:user).authentications.should_not be_empty
        end

        it "should assign the user's uid" do
          assigns(:user).authentications.first.uid.should == @auth_params[:uid]
        end

        it "should assign the provider" do
          assigns(:user).authentications.first.provider.should == @auth_params[:provider]
        end
      end
    end

    describe "with a missing email" do
      before do
        post :create, :user => FactoryGirl.build(:user, :email => nil).attributes
      end

      it "should assign an invalid user" do
        assigns(:user).should_not be_valid
      end

      it "should include a missing email error" do
        assigns(:user).errors.messages.should include(:email)
        assigns(:user).errors.messages[:email].should include("can't be blank")
      end

      it "should render the new (registrations) page" do
        response.should render_template("users/new")
      end

      it "should return an error" do
        flash[:error].should_not be_empty
      end
    end

    describe "with a duplicate email" do
      before do
        user = FactoryGirl.create :user
        post :create, :user => FactoryGirl.build(:user, :email => user.email).attributes
      end

      it "should assign an invalid user" do
        assigns(:user).should_not be_valid
      end

      it "should include a duplicate email error" do
        assigns(:user).errors.messages.should include(:email)
        assigns(:user).errors.messages[:email].should include("has already been taken")
      end

      it "should render the new (registrations) page" do
        response.should render_template("users/new")
      end

      it "should return an error" do
        flash[:error].should_not be_empty
      end
    end

    describe "with an invalid email" do
      before do
        post :create, :user => FactoryGirl.build(:user, :email => "bad_email_address")
      end

      it "should assign an invalid user" do
        assigns(:user).should_not be_valid
      end

      it "should include an invalid email error" do
        assigns(:user).errors.messages.should include(:email)
        assigns(:user).errors.messages[:email].should include("is not formatted properly")
      end

      it "should render the new (registrations) page" do
        response.should render_template("users/new")
      end

      it "should return an error" do
        flash[:error].should_not be_empty
      end
    end
  end
end
