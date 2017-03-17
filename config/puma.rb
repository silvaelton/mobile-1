#!/usr/bin/env puma

app_dir = File.expand_path('../../../', __FILE__)
shared_dir = File.expand_path('../../../shared', __FILE__)

environment "production"

bind  "unix://#{shared_dir}/tmp/sockets/puma.sock"
pidfile "#{shared_dir}/tmp/pids/puma.pid"
state_path "#{shared_dir}/tmp/sockets/puma.state"
directory "#{app_dir}/current"

workers 2
threads 1,2

daemonize true

activate_control_app "unix://#{shared_dir}/tmp/sockets/pumactl.sock"

prune_bundler