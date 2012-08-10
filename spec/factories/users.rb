FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'

    factory :user_with_condition do
      after :create do |user|
        FactoryGirl.create :condition, :user => user
      end
    end
  end
end
