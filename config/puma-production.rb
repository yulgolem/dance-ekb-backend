#!/usr/bin/env puma

require "pathname"

app_root = Pathname.new("/home/www/imi-backend/current")
shared_path = Pathname.new("/home/www/imi-backend/shared")

workers 2
threads 4, 8

directory app_root.to_s
rackup app_root.join("config.ru")

environment "production"

# pidfile    shared_path.join('tmp/pids/puma.pid')
# state_path shared_path.join('tmp/sockets/puma.state')

stdout_redirect shared_path.join("log/puma.log"), shared_path.join("log/puma.err.log"), true

# bind "unix://#{shared_path.join('tmp/sockets/puma.sock')}"

prune_bundler

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart
