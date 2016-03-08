require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.require(*Rails.groups)
require "hot_date_rails"

module Dummy
  class Application < Rails::Application
    config.time_zone = 'Eastern Time (US & Canada)'
	  config.serve_static_files = true
  end
end


