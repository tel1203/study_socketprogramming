# tcpserver program:
#   ruby tcpserver.rb <PORT#>
#  ex
#   ruby tcpserver.rb 12345

require "socket"
ports = 16152
host = "127.0.0.1"
port = ARGV[0].to_i
res = ""
s0 = TCPServer.open(port)

while true
	Thread.fork(s0.accept) do |sock|
		while buf = sock.gets
			puts buf
			sock.puts(buf)
		end		
	end
end
#sock.close
#s0.close
