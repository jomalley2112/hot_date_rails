ENV['RAILS_ENV'] ||= 'test'
require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rspec/rails'
#require 'rspec/autorun'
require 'factory_girl_rails'
require 'database_cleaner'
require 'capybara/rails'
require 'capybara/rspec'
require 'pry-rails'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.mock_with :rspec
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include Capybara::DSL
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
  config.color = true
  config.use_transactional_fixtures = false
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end


#For testing jQuery UI slider widget
module CapybaraExtension
  def drag_by(right_by, down_by)
    base.drag_by(right_by, down_by)
  end
end
module CapybaraSeleniumExtension
  def drag_by(right_by, down_by)
    driver.browser.action.drag_and_drop_by(native, right_by, down_by).perform
  end
end
::Capybara::Selenium::Node.send :include, CapybaraSeleniumExtension
::Capybara::Node::Element.send :include, CapybaraExtension