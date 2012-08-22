require 'spec_helper'

describe ConditionsController do
  before (:each) do
    @user = FactoryGirl.create :user
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

  describe "PUT 'update'" do
    it "should find the correct the user" do
      put :update, :user_id => @user.id
      assigns(:user).should == @user
    end

    it "should find the correct condition" do
      put :update, :user_id => @user.id
      assigns(:condition).should == @user.condition
    end

    describe "for a condition's state" do
      it "should update to reflect 'IN'" do
        put :update, :user_id => @user.id, :condition => { :state => "true" }
        assigns(:condition).state.should == true
      end

      it "should update to reflect 'OUT'" do
        put :update, :user_id => @user.id, :condition => { :state => "false" }
        assigns(:condition).state.should == false
      end
    end
  end
end
