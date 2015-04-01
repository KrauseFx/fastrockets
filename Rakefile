pi = ENV["RASPBERRY_IP"] || "10.0.0.26"
user = ENV["RASPBERRY_USER"] || "pi"
folder = ENV["RASPBERRY_FOLDER"] || "/home/pi/fastrockets/"

task :transfer do
  sh "gcc c.c"
  sh "sshpass -p '#{ENV["RASPBERRY_PASS"]}' scp *.out *.rb #{user}@#{pi}:#{folder}"
end

task :default => [:transfer]