##
# Backup v5.x Configuration
#
# Documentation: http://meskyanichi.github.io/backup
# Issue Tracker: https://github.com/meskyanichi/backup/issues

##
# Config Options
#
# The options here may be overridden on the command line, but the result
# will depend on the use of --root-path on the command line.
#
# If --root-path is used on the command line, then all paths set here
# will be overridden. If a path (like --tmp-path) is not given along with
# --root-path, that path will use it's default location _relative to --root-path_.
#
# If --root-path is not used on the command line, a path option (like --tmp-path)
# given on the command line will override the tmp_path set here, but all other
# paths set here will be used.
#
# Note that relative paths given on the command line without --root-path
# are relative to the current directory. The root_path set here only applies
# to relative paths set here.
#
# ---
#
# Sets the root path for all relative paths, including default paths.
# May be an absolute path, or relative to the current working directory.
#
# root_path 'my/root'
#
# Sets the path where backups are processed until they're stored.
# This must have enough free space to hold apx. 2 backups.
# May be an absolute path, or relative to the current directory or +root_path+.
#
# tmp_path  'my/tmp'
#
# Sets the path where backup stores persistent information.
# When Backup's Cycler is used, small YAML files are stored here.
# May be an absolute path, or relative to the current directory or +root_path+.
#
# data_path 'my/data'

##
# Utilities
#
# If you need to use a utility other than the one Backup detects,
# or a utility can not be found in your $PATH.
#
#   Utilities.configure do
#     tar       '/usr/bin/gnutar'
#     redis_cli '/opt/redis/redis-cli'
#   end

##
# Logging
#
# Logging options may be set on the command line, but certain settings
# may only be configured here.
#
#   Logger.configure do
#     console.quiet     = true            # Same as command line: --quiet
#     logfile.max_bytes = 2_000_000       # Default: 500_000
#     syslog.enabled    = true            # Same as command line: --syslog
#     syslog.ident      = 'my_app_backup' # Default: 'backup'
#   end
#
# Command line options will override those set here.
# For example, the following would override the example settings above
# to disable syslog and enable console output.
#   backup perform --trigger my_backup --no-syslog --no-quiet

##
# Component Defaults
#
# Set default options to be applied to components in all models.
# Options set within a model will override those set here.
#
#   Storage::S3.defaults do |s3|
#     s3.access_key_id     = "my_access_key_id"
#     s3.secret_access_key = "my_secret_access_key"
#   end
#
#   Notifier::Mail.defaults do |mail|
#     mail.from                 = 'sender@email.com'
#     mail.to                   = 'receiver@email.com'
#     mail.address              = 'smtp.gmail.com'
#     mail.port                 = 587
#     mail.domain               = 'your.host.name'
#     mail.user_name            = 'sender@email.com'
#     mail.password             = 'my_password'
#     mail.authentication       = 'plain'
#     mail.encryption           = :starttls
#   end

##
# Preconfigured Models
#
# Create custom models with preconfigured components.
# Components added within the model definition will
# +add to+ the preconfigured components.
#
#   preconfigure 'MyModel' do
#     archive :user_pictures do |archive|
#       archive.add '~/pictures'
#     end
#
#     notify_by Mail do |mail|
#       mail.to = 'admin@email.com'
#     end
#   end
#
#   MyModel.new(:john_smith, 'John Smith Backup') do
#     archive :user_music do |archive|
#       archive.add '~/music'
#     end
#
#     notify_by Mail do |mail|
#       mail.to = 'john.smith@email.com'
#     end
#   end

##
# Backup Generated: backup
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t backup [-c <path_to_configuration_file>]
#

RAILS_ENV = ENV["RAILS_ENV"] || "development"

config = YAML.load_file File.expand_path("../database.yml",  __FILE__)
secrets = YAML.load_file File.expand_path("../secrets.yml",  __FILE__)

Backup::Model.new(:db_backup, "Daily backup") do
  ##
  # Split [Splitter]
  #
  # Split the backup file in to chunks of 250 megabytes
  # if the backup file size exceeds 250 megabytes
  #
  split_into_chunks_of 250

  Utilities.configure do
    pg_dump "~/docker_pg_dump.sh"
    redis_cli "~/docker_redis-cli.sh"
  end

  database PostgreSQL do |db|
    db.name               = config[RAILS_ENV]["database"]
    db.username           = config[RAILS_ENV]["username"]
    db.password           = config[RAILS_ENV]["password"]
    db.host               = config[RAILS_ENV]["host"]
    db.port               = config[RAILS_ENV]["port"]
    db.skip_tables        = []
  end

  database Redis do |db|
    db.mode = :sync # or :sync
    db.host = "localhost"
    db.port = 6379
    # db.socket             = '/tmp/redis.sock'
    db.password           = secrets[RAILS_ENV]["redis_pass"]
    db.additional_options = []
  end

  # Amazon Simple Storage Service [Storage]
  #
  # Available Regions:
  #
  #  - ap-northeast-1
  #  - ap-southeast-1
  #  - eu-west-1
  #  - us-east-1
  #  - us-west-1

  store_with S3 do |s3|
    s3.access_key_id     = secrets[RAILS_ENV]["aws_backup_access_key_id"]
    s3.secret_access_key = secrets[RAILS_ENV]["aws_backup_secret_access_key"]
    s3.region            = Settings.aws.buckets.static
    s3.bucket            = Settings.aws.s3.region
    s3.path              = config[RAILS_ENV]["database"]
    s3.keep              = 60
  end

  ##
  # Gzip [Compressor]
  #
  compress_with Gzip

  store_with Local do |local|
    local.path = "~/backups/"
    # Use a number or a Time object to specify how many backups to keep.
    local.keep = 60
  end

  # notify_by Slack do |slack|
  #   slack.on_success = false
  #   slack.on_warning = true
  #   slack.on_failure = true
  #
  #   # The integration token
  #   slack.webhook_url = 'DRAFT_PROJECT_SLACK_HOOK'
  #
  #   ##
  #   # Optional
  #   #
  #   # The channel to which messages will be sent
  #   slack.channel = '#monitoring'
  #   #
  #   # The username to display along with the notification
  #   slack.username = 'db_backup'
  #   #
  #   # The emoji icon to use for notifications.
  #   # See http://www.emoji-cheat-sheet.com for a list of icons.
  #   slack.icon_emoji = ':ghost:'
  # end
end
