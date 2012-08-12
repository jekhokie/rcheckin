class Condition < ActiveRecord::Base
  belongs_to :user

  attr_accessible :state
end
