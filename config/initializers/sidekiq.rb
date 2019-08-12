if Settings.redis.try(:url)
  puts "Connecting to redis at #{Settings.redis.url}"
  ENV["REDIS_URL"] = Settings.redis.url
end

# Sidekiq::MAX_COUNT = 10000
