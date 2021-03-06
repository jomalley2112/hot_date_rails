module HotDateRails
  class Engine < ::Rails::Engine
  	#isolate_namespace HotDateRails

		config.generators do |g|
			g.test_framework :rspec, :fixture => false
			g.integration_tool :rspec
			g.fixture_replacement :factory_girl, :dir => 'spec/factories'
			g.assets false
			g.helper false
		end
  end

  def self.config(&block)
    yield Engine.config if block
    Engine.config
  end
end
