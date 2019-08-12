require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require 'rails/test_unit/railtie'
require "uglifier"

groups = {
  assets: %w[development test],
  monitoring: %w[production staging],
}

Bundler.require(*Rails.groups(groups))

module ImiProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths << Rails.root.join("lib")
    config.autoload_paths << Rails.root.join("services")
    config.autoload_paths << Rails.root.join("interactions")
    config.eager_load_paths << Rails.root.join("lib")
    config.eager_load_paths << Rails.root.join("services")
    config.eager_load_paths << Rails.root.join("interactions")

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run 'rake -D time' for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "Europe/Moscow"

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :ru
    config.i18n.fallbacks = false

    # Do not swallow errors in after_commit/after_rollback callbacks.
    # config.active_record.raise_in_transactional_callbacks = true

    config.generators.assets = false
    config.generators.helper = false

    config.generators.test_framework = nil
    # config.generators.test_framework = :rspec
    # config.generators.fixture_replacement :factory_bot, dir: 'spec/factories'

    config.active_job.queue_adapter = :sidekiq
  end
end
