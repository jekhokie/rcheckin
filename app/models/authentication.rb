class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid

  belongs_to :user

  validates :uid,      :presence => true, :uniqueness => { :scope => :provider }
  validates :provider, :presence => true, :uniqueness => { :scope => :user_id  }
  validates :user,     :presence => true

  @@providers = [ "facebook", "github", "twitter" ]

  def self.providers
    @@providers
  end
end
