require 'spec_helper'

describe User do
  before(:each) do
    @attr = {
      :name => "Example User",
      :email => "user@example.com"
    }
  end

  it "can be instantiated" do
    User.new.should be_an_instance_of(User)
  end

  specify { FactoryGirl.build(:user).should be_valid }

  it "should create a new instance given a valid attribute" do
    User.create!(@attr)
  end

  it "should require an email address" do
    no_email_user = User.new @attr.merge(:email => "")
    no_email_user.should_not be_valid
  end

  it "should accept valid email addresses" do
    addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      valid_email_user = User.new @attr.merge(:email => address)
      valid_email_user.should be_valid
    end
  end

  it "should reject invalid email addresses" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    User.create!(@attr)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
    User.create! @attr.merge(:email => @attr[:email].upcase)
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end

  it "should create an initial condition when created" do
    user = User.create! @attr
    user.condition.should_not be_nil
  end

  describe "state" do
    before(:all) do
      @user = FactoryGirl.create :user
      @condition = @user.condition
    end

    it "should have a state method" do
      @user.should respond_to(:state)
    end

    it "should report 'IN' for condition state" do
      @condition.update_attribute :state, true
      @user.state.should == "IN"
    end

    it "should report 'OUT' for condition state" do
      @condition.update_attribute :state, false
      @user.state.should == "OUT"
    end
  end
end
