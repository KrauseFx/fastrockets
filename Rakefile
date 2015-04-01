pi = ENV["RASPBERRY_IP"] || "10.0.0.26"
user = ENV["RASPBERRY_USER"] || "pi"
folder = ENV["RASPBERRY_FOLDER"] || "/home/pi/fastrockets/"

task :transfer do
  sh "sshpass -p '#{ENV["RASPBERRY_PASS"]}' scp *.cc Makefile #{user}@#{pi}:#{folder}"
  sh "sshpass -p '#{ENV["RASPBERRY_PASS"]}' ssh #{user}@#{pi} -t 'cd #{folder}; make; sudo ruby server.rb'"
end

task :run do
  sh "cd rpi-rgb-led-matrix && make"
  sh "make"
  sh "sudo ruby server.rb"
end

task :default => [:run]
