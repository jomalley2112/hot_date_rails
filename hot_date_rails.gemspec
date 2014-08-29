$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "hot_date_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "hot_date_rails"
  s.version     = HotDateRails::VERSION
  s.authors     = ["John O'Malley"]
  s.email       = ["jom@nycap.rr.com"]
  s.homepage    = "https://github.com/jomalley2112/hot_date_rails"
  s.summary     = "Summary of HotDateRails."
  s.description = "Description of HotDateRails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.1.5"
  s.add_dependency "coffee-rails"
  s.add_dependency 'jquery-rails'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'pry-rails'
end
