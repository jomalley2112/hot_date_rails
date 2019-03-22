require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'rails/all'
require 'mongoid'

Bundler.require(*Rails.groups)
require "hot_date_rails"

module Dummy
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'
	  config.public_file_server.enabled = true
	  config.active_record.sqlite3.represent_boolean_as_integer = true
  end
end


