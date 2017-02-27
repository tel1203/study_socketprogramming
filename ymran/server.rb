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
	sock = s0.accept
	s1 = TCPSocket.open(host, ports)
	while buf = sock.gets
		puts buf
		s1.write(buf)
	end
	
end
#sock.close
#s0.close
