FactoryGirl.define do
  factory :authentication do
    user

    provider { "provider_#{Authentication.all.count + 1}" }
    uid      { "uid_#{Authentication.all.count + 1}" }
  end
end
