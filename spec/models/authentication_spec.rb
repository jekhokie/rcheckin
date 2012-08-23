require 'spec_helper'

describe Authentication do
  it "can be instantiated" do
    Authentication.new.should be_an_instance_of(Authentication)
  end

  specify { FactoryGirl.build(:authentication).should be_valid }

  it "should belong to a user" do
    authentication = FactoryGirl.build(:authentication, :user => nil)

    authentication.should_not be_valid
    authentication.errors.messages.should include(:user)
    authentication.errors.messages[:user].should include("can't be blank")
  end

  describe "uid" do
    it "should be required" do
      FactoryGirl.build(:authentication, :uid => nil).should_not be_valid
    end

    it "should reject duplicate uids for the same provider" do
      authentication = FactoryGirl.create :authentication
      FactoryGirl.build(:authentication, :provider => authentication.provider, :uid => authentication.uid).should_not be_valid
    end

    it "should allow duplicate uids across different providers" do
      authentication = FactoryGirl.create :authentication
      FactoryGirl.build(:authentication, :uid => authentication.uid).should be_valid
    end
  end

  describe "provider" do
    it "should be required" do
      FactoryGirl.build(:authentication, :provider => nil).should_not be_valid
    end

    it "should reject duplicate providers for the same user" do
      authentication = FactoryGirl.create :authentication
      FactoryGirl.build(:authentication, :user => authentication.user, :provider => authentication.provider).should_not be_valid
    end
  end
end
