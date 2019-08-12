source "https://rubygems.org"
ruby "2.6.2"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "pg"
gem "rails", "~> 5.2.2"

group :assets do
  gem "coffee-rails"
  gem "sass-rails"
  # gem 'therubyracer' # v8 interpreter
  gem "uglifier"
end

gem "jquery-rails"
gem "jquery-ui-rails"
gem "oj"
# gem 'semantic-ui-sass' # active development of semantic-ui paused, so use fomantic-ui for now
gem "fomantic-ui-sass" # sass version of community form of semantic-ui
gem "slim-rails"

gem "bootsnap", require: false
gem "config"
gem "puma"
gem "sidekiq"
gem "sidekiq-history"

gem "cancancan"
gem "devise"
gem "jwt"
gem "rbnacl" # requiries libsodium in system
# gem 'redis-mutex'
# gem 'paper_trail'

# gem 'groupdate'
gem "kramdown"
gem "phonelib" # phone number formatting according to google libphonenumber
gem "responders"
gem "simple_form"

# PDF export
# gem 'wicked_pdf'
# gem 'wkhtmltopdf-binary-edge' # , '~> 0.12.3.0'
gem "mutool"

gem "admino"
gem "cocoon"
# gem 'deep_cloneable'
gem "kaminari"
gem "active_model_serializers"

gem "faraday" # , '~> 0.15.0'
gem "faraday_middleware"

# API
gem "friendly_id" # , '~> 5.1.0'
# gem 'graphql'
# gem 'graphiql-rails', group: :development # use standalone graphiql (preferred) or graphql-playground app
# gem 'graphql-docs'
# solving N+1 query
# gem 'graphql-batch' # for belongs_to relations
# gem 'graphql-preload' # for has_many relations # looks like solved in recent versions
gem "jsonapi-resources"
gem "activerecord_lax_includes", github: "brigade/active-record-lax-includes"

# gem 'aws-sdk', '~> 3'
gem "aws-sdk-s3"
gem "fastimage" # dependency for store_dimensions plugin
gem "image_processing"
gem "mini_magick"
gem "shrine"

gem "whenever", require: false

gem "nokogiri" # dependency for premailer-rails
gem "premailer-rails"

# gem 'sitemap_generator'

gem "apitome" # , git: ''
gem "gibbon"
gem "slack-notifier"

group :production, :staging do
  gem "lograge"
end

group :monitoring do
  # gem 'newrelic_rpm'
  gem "rollbar"
end

group :development, :test do
  gem "spring"
  gem "pry"
  gem "pry-rails"
  gem "guard-rspec", require: false
  gem "rails-erd", require: false
  gem "simplecov", require: false
  gem "standard"

  # gem 'web-console', '>= 3.3.0'
  # gem 'listen', '>= 3.0.5', '< 3.2'
  # gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem "database_cleaner"
  gem "rspec"
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "rspec-graphql_matchers"
  gem "rspec_api_documentation"
  gem "shoulda-matchers"
  gem "spring-commands-rspec"
  # gem 'timecop'
  # gem 'vcr', require: false
  gem "webmock", require: false
end

gem "faker"
gem "russian" # , git: ''
gem "translit"

group :development do
  gem "active_record-annotate", "~> 0.4"
  gem "letter_opener"
  gem "seed_dump"

  gem "mina", "< 1.0", require: false
  gem "mina-multistage", require: false
  gem "mina-slack", require: false # , git: ''

  gem "guard"

  gem "better_errors"
  gem "binding_of_caller"
  # gem 'guard-livereload', require: false
  # gem 'rack-livereload'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 2.0'
end
