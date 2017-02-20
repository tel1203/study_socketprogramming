# tcpserver program:
#   ruby tcpserver.rb <PORT#>
#  ex
#   ruby tcpserver.rb 12345

require "socket"

port = ARGV[0].to_i

s0 = TCPServer.open(port)

sock = s0.accept
while buf = sock.gets
  p buf
end

sock.close
s0.close
