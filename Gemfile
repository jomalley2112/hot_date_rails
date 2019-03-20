source "https://rubygems.org"

# Declare your gem's dependencies in hot_date_rails.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.

gemspec

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]

group :test do
	gem 'fuubar', '~> 2.3.2', platforms: [:ruby]
end

group :test, :development do
	gem 'sqlite3'
	gem 'pry-rails'
	#TODO: Apparently because of something homebrew screwed up version-wise (https://stackoverflow.com/questions/16756287/cannot-execute-rails-console-due-to-an-error-with-readline). Hopefully can remove it at some point
	gem 'rb-readline' 
end

# Declare any dependencies that are still in development here instead of in
# your gemspec. These might include edge Rails or gems from your path or
# Git. Remember to move these dependencies to your gemspec before releasing
# your gem to rubygems.org.

# To use debugger
# gem 'debugger'
