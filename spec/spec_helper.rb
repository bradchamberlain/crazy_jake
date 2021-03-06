unless ENV['REMOTE_INTEGRATION']
  require 'webmock/rspec'
  require 'simplecov'
  SimpleCov.minimum_coverage 100
  SimpleCov.start 'rails' do
    # Demo is temporary; to be remove and reimplemented later
    add_filter "/app/controllers/demo_controller.rb"
  end

  SimpleCov.at_exit do
    SimpleCov.result.format!
    if SimpleCov.result.covered_percent < SimpleCov.minimum_coverage
      fail_msg = "#{'%.2f' % SimpleCov.result.covered_percent}% test coverage?? Really??!!"
      STDERR.puts "\0
#{fail_msg}\033[0m\nWrite more tests"
      exit 1
    end
  end
end

# This file is copied to spec.css/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] = 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec.css/support/ and its subdirectories.
Dir[Rails.root.join("spec.css/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|

  RSpec.configure do |config|
    config.include Devise::TestHelpers, :type => :controller
  end
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec.css/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
