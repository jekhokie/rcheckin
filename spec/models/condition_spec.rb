require 'spec_helper'

describe Condition do
  it "can be instantiated" do
    Condition.new.should be_an_instance_of(Condition)
  end

  specify { FactoryGirl.build(:condition).should be_valid }
end
