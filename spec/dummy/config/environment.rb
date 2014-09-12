# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

HotDateRails.config do |config|
	config.minute_grid = "15"
end