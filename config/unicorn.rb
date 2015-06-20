# -*- coding: utf-8 -*-
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

listen File.expand_path("tmp/unicorn.sock", ENV["RAILS_ROOT"])
pid File.expand_path("tmp/unicorn.pid", ENV["RAILS_ROOT"])

before_fork do |_server, _worker|
  Signal.trap "TERM" do
    puts "Unicorn master intercepting TERM and sending myself QUIT instead"
    Process.kill "QUIT", Process.pid
  end

  ActiveRecord::Base.connection.disconnect! if defined? ActiveRecord::Base
end

after_fork do |_server, _worker|
  Signal.trap "TERM" do
    puts "Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT"
  end

  ActiveRecord::Base.establish_connection if defined? ActiveRecord::Base
end

stderr_path File.expand_path("log/unicorn.log", ENV["RAILS_ROOT"])
stdout_path File.expand_path("log/unicorn.log", ENV["RAILS_ROOT"])
