require "openssl"
require "mina/multistage"
require "mina/bundler"
require "mina/rails"
require "mina/git"
require "mina/rbenv"
require "mina/slack"
# require 'mina_sidekiq/tasks'

set :default_stage, :production
set :deploy_to, "/home/www/imi-backend"
# set :repository, 'git@gitlab.com:perushevandkhmelev/<some_path>/<some_repo>.git'
set :app_path, "#{deploy_to}/#{current_path}"
# set :branch, ''
set :keep_releases, 200

# set :slack_url, ''

# set :slack_room, '#site_monitoring'
# set :slack_username, 'Deploybot'
# set :slack_emoji, ':rocket:'

# set :slack_application, 'IMI backend'

set :shared_paths, %w[
  config/database.yml
  log
  tmp
  public/assets
  public/uploads
  public/shared
  config/secrets.yml
  config/settings.local.yml
] # config/master.key

set :user, "www"

# set :bundle_prefix, -> { %{RAILS_ENV="#{rails_env}" NEW_RELIC_APP_NAME="arch backend (#{stage});arch backend" #{bundle_bin} exec} }
set :bundle_prefix, -> { %(RAILS_ENV="#{rails_env}" #{bundle_bin} exec) }

set :puma_config, "config/puma.rb"

# set :sidekiq_log, -> { "#{deploy_to}/#{shared_path}/log/sidekiq.log" }
# set :sidekiq_pid, -> { "#{deploy_to}/#{shared_path}/tmp/pids/sidekiq.pid" }

task :environment do
  invoke :'rbenv:load'
end

desc "Restarts the web server"
task restart: :environment do
  queue! %(echo -e "host: \033[1;35m`hostname`\033[0m", stage: #{stage})
  invoke :'puma:restart'
  invoke :'sidekiq:restart'
end

task start: :environment do
  queue! %(echo -e "host: \033[1;35m`hostname`\033[0m", stage: #{stage})
  invoke :'puma:start'
  invoke :'sidekiq:start'
end

task stop: :environment do
  queue! %(echo -e "host: \033[1;35m`hostname`\033[0m", stage: #{stage})
  invoke :'puma:stop'
  invoke :'sidekiq:stop'
end

namespace :nginx do
  task :test do
    system "ssh root@#{domain} nginx -t"
  end

  task :reload do
    system "ssh root@#{domain} nginx -s reload"
  end
end

task setup: :environment do
  %w[log tmp tmp/pids tmp/sockets config public public/uploads public/assets public/shared].each do |dir|
    queue! %(mkdir -p "#{deploy_to}/shared/#{dir}")
    queue! %(chmod g+rx,u+rwx "#{deploy_to}/shared/#{dir}")
  end
end

namespace :whenever do
  desc "Update crontab"
  task :update do
    queue %(
      echo "-----> Update crontab for #{domain}_#{rails_env}, roles: #{whenever_roles.join(",")}"
      #{echo_cmd %(#{bundle_bin} exec whenever --update-crontab #{domain}_#{rails_env} --set 'environment=#{rails_env}&path=#{deploy_to!}/#{current_path!}' --roles=#{whenever_roles.join(",")})}
    )
  end
end

namespace :rails do
  # Modify default task assets_precompile to support symlinking assets directory
  desc "Precompiles assets (skips if nothing has changed since the last release)."
  task :assets_precompile_with_symlink do
    if ENV["force_assets"]
      invoke :'rails:assets_precompile:force'
    else
      message = verbose_mode? ? "$((count)) changes found, precompiling asset files" : "Precompiling asset files"

      queue check_for_changes_script \
        check: "public/assets/",
        at: [*asset_paths],
        skip: %(echo "-----> Skipping asset precompilation"),
        changed: %(
          echo "-----> #{message}"
          #{echo_cmd rake_assets_precompile.to_s}
        ),
        default: %(
          echo "-----> Precompiling asset files"
          #{echo_cmd rake_assets_precompile.to_s}
        )
    end
  end

  # ### rails:db_seed
  desc "Seeds the Rails database."
  task :db_seed do
    queue %(
      echo "-----> Seeding database"
      #{echo_cmd %(#{rake} db:seed)}
    )
  end
end

namespace :puma do
  desc "Stopping puma"
  task stop: :environment do
    queue %(echo "-----> Stop puma")
    queue! %(sudo systemctl stop puma.service)
  end

  desc "Starting puma"
  task start: :environment do
    queue %(echo "-----> Start puma")
    queue! %(sudo systemctl start puma.service)
  end

  desc "Restarting puma"
  task :restart do
    queue %(echo "-----> Restart puma")
    queue! %(sudo systemctl restart puma.service)
  end
end

namespace :sidekiq do
  desc "Quiet sidekiq (stop accepting new work)"
  task quiet: :environment do
    queue %[echo "-----> Quiet sidekiq (stop accepting new work)"]
    queue! %(pgrep -f 'sidekiq' | xargs kill -TSTP)
  end

  desc "Stopping sidekiq"
  task stop: :environment do
    queue %(echo "-----> Stop sidekiq")
    queue! %(sudo systemctl stop sidekiq.service)
  end

  desc "Starting sidekiq"
  task start: :environment do
    queue %(echo "-----> Start sidekiq")
    queue! %(sudo systemctl start sidekiq.service)
  end

  desc "Restarting sidekiq"
  task :restart do
    queue %(echo "-----> Restart sidekiq")
    queue! %(sudo systemctl restart sidekiq.service)
  end
end
