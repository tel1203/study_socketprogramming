require "socket"

host = "127.0.0.1" #ARGV[0]
port = 16151 #ARGV[1]
puts "Username"
$username = gets
$username.strip
$Usend = false
sock = TCPSocket.open(host, port)

def send(sock)

	while true
		
		if !$Usend then
			sock.write("1,"+$username)
			$Usend = true
		else
			message = gets
			
			break if message == "quit" 
			sock.write($username.strip+": "+message)
		end	
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
