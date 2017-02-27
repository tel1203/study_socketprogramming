
require "socket"
host = "127.0.0.1"
port = ARGV[0].to_i
s0 = TCPServer.open(port)
#push the server in  the  socket list
socks = []
socks.push(s0)

while true
	#creat the socket list
	select = IO::select(socks,nil,nil,nil)
	select[0].each do |sock|
		 
		#recv new socket
		if sock == s0 then
			client = sock.accept
			socks.push(client)
		#recv msg form a socket
		else
			#read the msg
			buf = sock.recvfrom(20)[0]
			puts buf
			#send the reply
			sock.puts("recievd msg: "+buf)	
		end
	end
end

