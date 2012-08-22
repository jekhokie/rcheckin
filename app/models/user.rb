class User < ActiveRecord::Base
  attr_accessible :name, :email

  has_one :condition

  before_create :initialize_condition

  validates :email, :presence     => true,
                    :email_format => true,
                    :uniqueness   => { :case_sensitive => false }

  def state
    condition.nil? ? "" : (condition.state ? "IN" : "OUT")
  end

  private
  def initialize_condition
    self.condition = Condition.create
  end
end
