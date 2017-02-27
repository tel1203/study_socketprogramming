require "socket"
ports = 16152
host = "127.0.0.1"
port = ARGV[0].to_i
res = ""
s0 = TCPServer.open(port)
#create a thread for each socket conneciton
while true
	Thread.fork(s0.accept) do |sock|
		while buf = sock.gets
			puts buf
			sock.puts(buf)
		end		
	end
end
