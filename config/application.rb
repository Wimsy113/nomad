require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Nomad
  class Application < Rails::Application

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # If you’re building a public API you’ll probably want to enable
    # Cross-Origin Resource Sharing (CORS), in order to make cross-origin AJAX
    # requests possible.

    config.middleware.insert_before 0, "Rack::Cors" do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :put, :post, :patch, :delete, :options]
      end
    end

    # To protect our API from DDoS, brute force attacks, hammering, or even to
    # monetize with paid usage limits, we can use a Rake middleware called Rack::Attack.
    # The rack-attack gem was released by Kickstarter, and it allows us to:

    # whitelist: Allowing it to process normally if certain conditions are true
    # blacklist: Sending a denied message instantly for certain requests
    # throttle: Checking if the user is within their allowed usage
    # track: Tracking this request to be able to log certain information about our requests

    config.middleware.use Rack::Attack

  end
end
