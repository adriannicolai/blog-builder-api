require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module BlogBuilder
	class Application < Rails::Application
		# Initialize configuration defaults for originally generated Rails version.
		config.load_defaults 7.0

		# Configuration for the application, engines, and railties goes here.
		#
		# These settings can be overridden in specific environments using the files
		# in config/environments, which are processed later.
		#
		# config.time_zone = "Central Time (US & Canada)"
		# config.eager_load_paths << Rails.root.join("extras")

		# Add the yml file
		config.before_configuration do
			env_file = File.join(Rails.root, 'config', 'local_env.yml')
			YAML.load(File.open(env_file)).each do |key, value|
				ENV[key.to_s] = value
			end if File.exists?(env_file)
		end

		# Set the app to be api only
		config.api_only = true

		# Auto delete temporary files
		config.middleware.use Rack::Tempfilereaper

		# Add host here
		# config.hosts << "blog_builderapi.com"
	end
end
