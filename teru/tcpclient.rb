# tcp client program:
#  ruby tcpclent.rb <SERVER IP> <SERVER PORT> <SENDING MESSAGE>
# ex:
#  ruby tcpclent.rb localhost 20000 TestMessage
#
require "socket"

host = ARGV[0]
port = ARGV[1]
message = ARGV[2]

sock = TCPSocket.open(host, port)
sock.write(message)
sock.close

