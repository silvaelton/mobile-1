# This file is used by Rack-based servers to start the application.
# Unicorn self-process killer
# require 'unicorn/worker_killer'
#
# use Unicorn::WorkerKiller::MaxRequests, 3072, 4096
#
# use Unicorn::WorkerKiller::Oom, (192*(1024**2)), (256*(1024**2))
#
require_relative 'config/environment'

run Rails.application
