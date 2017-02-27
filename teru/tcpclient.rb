# tcp client program:
#  ruby tcpclent.rb <SERVER IP> <SERVER PORT> <SENDING MESSAGE>
# ex:
#  ruby tcpclent.rb localhost 20000 TestMessage
#
require "socket"

host = ARGV[0]
port = ARGV[1]
message = ARGV[2]
#message = "GET / HTTP/1.0\n\n"

sock = TCPSocket.open(host, port)
sock.print(message)
result = sock.read
sock.close
p result

