require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsVuejs
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.middleware.insert_before 0, Rack::Cors do # TODO: This CORS fix could be better...
      allow do
        # origins '*' # TODO: Yeah... this isn't ideal :(
        # origins 'http://localhost:3000'
        origins 'localhost:3000', '127.0.0.1:3000'
        # resource '*', :headers => :any, :methods => [:get, :post, options]
        resource '*', :headers => :any, :methods => [:get, :post]
      end
    end
  end
end
