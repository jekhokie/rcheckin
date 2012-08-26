# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # Clean up the database
  require 'database_cleaner'

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end

  # OmniAuth mock object configuration
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:facebook] = {
    "provider" => "facebook",
    "uid" => "1241241",
    "info" => { "email" => "test@example.com" }
  }

  OmniAuth.config.mock_auth[:github] = {
    "provider" => "github",
    "info" => {
      "email" => "test@example.com",
    },
    "extra" => {
      "raw_info" => {
        "id" => "1241513"
      }
    }
  }

  OmniAuth.config.mock_auth[:google] = {
    "provider" => "google",
    "uid" => "523525",
    "info" => { "email"  => "test@example.com" }
  }
end
