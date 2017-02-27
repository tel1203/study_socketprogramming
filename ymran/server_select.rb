
require "socket"
host = "127.0.0.1"
port = ARGV[0].to_i
s0 = TCPServer.open(port)
#push the server in  the  socket list
socks = []
username = ["Server"]
socks.push(s0)

while true
	#creat the socket list
	select = IO::select(socks,nil,nil,nil)
	
	select[0].each do |sock|
		index = socks.index(sock)-1
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
				buf = username[index]+" disconnected!"
				socks.delete(sock)
				username.delete(username[index])
			end
			#get username
			if buf.split(",").first == "1" then
				username[index] = buf.split(",").last.strip
				buf = username[index]+" connected!"
			end			
			puts buf
			
			#send the reply
			socks.each do |socket|
				if socket != s0 and socket != sock then
					socket.puts(buf)
				end
			end			
		end
	end
end

