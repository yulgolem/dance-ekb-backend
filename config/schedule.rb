# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, "log/whenever.log"

set :env_path, '"$HOME/.rbenv/shims":"$HOME/.rbenv/bin"'

job_type :rake,    ' cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec rake :task --silent :output '
job_type :script,  ' cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec script/:task :output '
job_type :runner,  ' cd :path && PATH=:env_path:"$PATH" :runner_command -e :environment ":task" :output '
job_type :execute, ' cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment bundle exec :task '
job_type :global,  ' cd :path && PATH=:env_path:"$PATH" RAILS_ENV=:environment :task '

set :chronic_options, hours24: true

# Server should be in Moscow timezone, dpkg-reconfigure tzdata to change
every 1.day, roles: %i[db], at: "8:00" do
  global "backup perform -t db_backup -c config/backup.rb"
end

# every :monday, roles: [:central], at: '11:00' do
#   rake "-s sitemap:refresh"
# end

# every 1.day, roles: %i[central], at: '03:00' do
#   global "aws s3 sync /home/www/imi-backend/shared/public/uploads/store/ s3://imi/store-static > /dev/null"
# end
#
# every 1.day, roles: %i[staging], at: '04:00' do
#   global "aws s3 sync /home/www/imi-backend/shared/public/uploads/store/ s3://imi/staging-store-static > /dev/null"
# end
