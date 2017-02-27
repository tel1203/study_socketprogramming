
require "socket"
host = "127.0.0.1"
port = ARGV[0].to_i
s0 = TCPServer.open(port)
#push the server in  the  socket list
socks = []
username = []
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

			buf = sock.gets
			#test if socket closed
			if buf == nil or buf.index("quit") == 0 then
				sock.close
				buf = "user disconected"
				socks.delete(sock)
			end
			puts buf
			
			#send the reply
			socks.each do |socket|
				if socket != s0 and socket != sock then
					socket.puts("recievd msg: "+buf)
				end
			end	
		end
	end
end

