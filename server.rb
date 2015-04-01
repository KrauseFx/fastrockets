require 'json'
require 'net/http'
require 'pty'

require './launcher'

SERVER_URL = "https://fastlane-refresher.herokuapp.com/"

command = "./minimal-example"

last_result = nil

launcher = FastRockets::Launcher.new

PTY.spawn(command) do |stdout, stdin, pid|
  loop do
    launches = JSON.parse(Net::HTTP.get(URI.parse(SERVER_URL)))
    if last_result
      diff = {}
      launches.each { |k, v| diff[k] = v - last_result[k] if v != last_result[k] }
      
      diff.each do |tool_name, launches|
        while launches > 0
          value = launcher.fire!(tool_name)
          stdin.puts value
          launches -= 1
        end
      end
    end
    last_result = launches
    last_result['deliver'] -= 1
    sleep 1.0

    stdin.puts "-1"
  end
end