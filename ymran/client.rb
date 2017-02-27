require "socket"

host = "127.0.0.1" #ARGV[0]
port = 16151 #ARGV[1]

sock = TCPSocket.open(host, port)

def send(sock)

	while true
		message = gets
		
		break if message == "quit" 
		sock.write(message)
	end
	sock.close
end

def recv(sock)
	
	while buf = sock.gets
		puts buf
	end	
end

tsend = Thread.new{send(sock)}
trecv = Thread.new{recv(sock)}

tsend.join
trecv.join
