require 'json'
require 'net/http'
require 'pty'
require 'thread'

require './launcher'

SERVER_URL = "http://fastlane-refresher.herokuapp.com/"

command = "./renderer"

last_result = nil

launcher = FastRockets::Launcher.new

mutex = Mutex.new


@current = nil

############# Network Thread #############
Thread.new do
  loop do
    launches = JSON.parse(Net::HTTP.get(URI.parse(SERVER_URL)))
    mutex.synchronize do
      @current = launches
    end
    sleep 10.0
  end
end


############# Led Thread #############

launches = nil
PTY.spawn(command) do |stdout, stdin, pid|
  loop do
    mutex.synchronize do
      launches = @current
    end

    if launches and last_result
      diff = {}
      launches.each { |k, v| diff[k] = v - last_result[k] if v != last_result[k] }
      
      diff.each do |tool_name, launches|
        while launches > 0
          value = launcher.fire!(tool_name)
          puts value
          stdin.puts value
          launches -= 1
        end
      end
    end
    last_result = launches
    sleep 0.5

    puts "-1"
    stdin.puts "-1"
  end
end