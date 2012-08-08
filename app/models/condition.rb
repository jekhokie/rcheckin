class Condition
  include Mongoid::Document

  field :status, type: Boolean

  embedded_in :user
end
