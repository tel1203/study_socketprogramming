# tcp client program:
#  ruby tcpclent.rb <SERVER IP> <SERVER PORT> <SENDING MESSAGE>
# ex:
#  ruby tcpclent.rb localhost 20000 TestMessage
#
require "socket"

host = "127.0.0.1" #ARGV[0]
port = 16151 #ARGV[1]
ports = 16152
s0 = TCPServer.open(ports)
sock = TCPSocket.open(host, port)

def send(sock)
	q= true
	while q
		message = gets
	
		if message === '/quit' then
			sock.write("user disconnected")
			sock.close
			q = false
		end
		sock.write(message)
	end
end

def recv(s0)

	while true
		sock = s0.accept
		while buf = sock.gets
			puts buf
		end	
	end
end

tsend = Thread.new{send(sock)}
trecv = Thread.new{recv(s0)}

tsend.join
trecv.join
