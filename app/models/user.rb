class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  has_one :condition

  before_create :initialize_condition

  def state
    condition.nil? ? "" : (condition.state ? "IN" : "OUT")
  end

  private
  def initialize_condition
    self.condition = Condition.create
  end
end
