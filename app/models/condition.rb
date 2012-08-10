class Condition < ActiveRecord::Base
  belongs_to :user

  attr_accessible :state

  before_create :initialize_state

  private
  def initialize_state
    self.state = true
  end
end
