FactoryGirl.define do
  factory :user do
    name  { "Test User #{User.all.count + 1}"          }
    email { "example#{User.all.count + 1}@example.com" }
  end
end
