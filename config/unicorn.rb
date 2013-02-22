working_directory "/usr/local/tvmethodist/current"
pid "/usr/local/tvmethodist/current/shared/pids/unicorn.pid"
stderr_path "/usr/local/tvmethodist/current/shared/log/unicorn.log"
stdout_path "/usr/local/tvmethodist/current/shared/log/unicorn.log"

listen "/tmp/unicorn.tvmethodist.sock"

worker_processes 3
timeout 30
preload_app true

before_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  sleep 1
end

after_fork do |server, worker|
  # Replace with MongoDB or whatever
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end
end
