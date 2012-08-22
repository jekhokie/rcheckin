require 'spec_helper'

describe User do
  it "can be instantiated" do
    User.new.should be_an_instance_of(User)
  end

  specify { FactoryGirl.build(:user).should be_valid }

  it "should create a new instance given a valid attribute" do
    FactoryGirl.create(:user).should be_valid
  end

  it "should require an email address" do
    FactoryGirl.build(:user, :email => "").should_not be_valid
  end

  it "should accept valid email addresses" do
    address_list = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    address_list.each do |address|
      FactoryGirl.build(:user, :email => address).should be_valid
    end
  end

  it "should reject invalid email addresses" do
    address_list = %w[user@foo,com user_at_foo.org example.user@foo.]
    address_list.each do |address|
      FactoryGirl.build(:user, :email => address).should_not be_valid
    end
  end

  it "should reject duplicate email addresses" do
    user = FactoryGirl.create :user
    FactoryGirl.build(:user, :email => user.email).should_not be_valid
  end

  it "should reject email addresses identical no matter the case" do
    user = FactoryGirl.create :user
    FactoryGirl.build(:user, :email => user.email.upcase).should_not be_valid
  end

  it "should create an initial condition when created" do
    FactoryGirl.create(:user).condition.should_not be_nil
  end

  it "should have many authentications" do
    user = FactoryGirl.create(:user)
    lambda { 2.times { FactoryGirl.create(:authentication, :user => user) } }.should change(user.authentications, :count).by(2)
  end

  describe "state" do
    before :all  do
      @user = FactoryGirl.create :user
      @condition = @user.condition
    end

    it "should have a state method" do
      @user.should respond_to(:state)
    end

    it "should report 'IN' for condition state" do
      @condition.update_attributes(:state => true)
      @user.state.should == "IN"
    end

    it "should report 'OUT' for condition state" do
      @condition.update_attributes(:state => false)
      @user.state.should == "OUT"
    end
  end
end
