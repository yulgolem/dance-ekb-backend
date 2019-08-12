require "shrine"
require "shrine/storage/file_system"

if Rails.env.production? || Rails.env.staging?
  require "shrine/storage/s3"

  s3_options = {
    region: Settings.aws.s3.region,
    bucket: Settings.aws.buckets.static,
    access_key_id: Rails.application.secrets.aws_access_key_id,
    secret_access_key: Rails.application.secrets.aws_secret_access_key,
  }

  # URL options for CDN
  # url_options = {
  #   public: true,
  #   host: "https://#{Settings.urls.static}"
  # }

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
    # store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/store'), # permanent
    # cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
    store: Shrine::Storage::S3.new(prefix: "store", **s3_options),
  }

  # Allows you to specify default URL options for uploaded files.
  # Shrine.plugin :default_url_options, store: url_options
else
  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "uploads/cache"), # temporary
    store: Shrine::Storage::FileSystem.new("public", prefix: "uploads/store"), # permanent
  }

  if Rails.env.production? || Rails.env.staging?
    url_options = {host: "https://#{Settings.urls.static}"}
    Shrine.plugin :default_url_options, store: url_options
  end
end

# Provides ActiveRecord integration, adding callbacks and validations.
Shrine.plugin :activerecord
# Automatically logs processing, storing and deleting, with a configurable format.
Shrine.plugin :logging, logger: Rails.logger
