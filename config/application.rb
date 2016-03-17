require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TinySocialNetwork
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end

    # Custom Errors
    require 'custom_errors'

    # Missing middlewares disabled by rails-api gem
    config.middleware.insert_after Rack::Runtime, Rack::MethodOverride
    config.middleware.insert_after ActiveRecord::QueryCache, ActionDispatch::Cookies
    config.middleware.insert_after ActionDispatch::Cookies, ActionDispatch::Flash
    config.middleware.insert_after ActionDispatch::Cookies, ActionDispatch::Session::CookieStore

    # Warden sessions:
    config.middleware.insert_after ActionDispatch::Flash, Warden::Manager do |manager|
      manager.serialize_into_session do |user|
        user.id
      end

      manager.serialize_from_session do |id|
        User.find_by_id(id)
      end

      manager.failure_app = UnauthorizedController
      manager.default_strategies :password
    end
  end
end
