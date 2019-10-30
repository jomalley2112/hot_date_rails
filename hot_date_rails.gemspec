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
  s.summary     = "A gem that extends Rails FormBuilder and FormTagHelper by adding date, time and datetime picker input functionality"
  s.description = "A gem that allows you to add date only, time only and datetime pickers to your forms. \
                  This gem also takes into account the way Ruby doesn't parse certain American-friendly dates \
                  so it passes along hidden fields with the values expected by rails. \
                  When updating the values they are 'localized' using the locale file to get them into the format \
                  expected by the picker."
  s.license     = "MIT"

  s.files = Dir["{app,config,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile"]
  # s.test_files = Dir["spec/**/*"]

  s.add_dependency "activerecord", '~> 6.0'
  s.add_dependency 'sprockets-rails'
  s.add_dependency 'rails-html-sanitizer' #, '~> 1.0.4'
  s.add_dependency 'coffee-rails', '~> 4.2'
  s.add_dependency 'jquery-rails', '~> 4.3'
  s.add_dependency 'ffi', '~> 1.9.24'
  s.add_dependency 'loofah' #, '~> 2.2.3'
  s.add_dependency 'rack', '~> 2.0.6' 
  s.add_dependency 'rubyzip', '>= 1.3.0'
  s.add_dependency "nokogiri", '~> 1.10.4'

  
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'database_cleaner', '>= 1.5.3'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'factory_bot_rails' #, '~> 5.0'
  s.add_development_dependency 'mongoid', '~> 7.0'
  s.add_development_dependency 'rspec-rails' #, '~> 3.8' 
  
end
