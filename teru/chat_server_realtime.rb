# tcpserver program:
#   ruby chat_server_thread.rb <PORT#>
#  ex
#   ruby chat_server_thread.rb 12345

require "socket"

port = ARGV[0].to_i

s0 = TCPServer.open(port) # bind & listen

array_sockets = Array.new
while (true) do
  # Waiting for new request
  printf("(Server)Socket Listening\n")
  sock = s0.accept
  printf("(Server->%s:%s)Socket Accepted:[%s]\n",
      sock.peeraddr[2], sock.peeraddr[1], sock.peeraddr.inspect)

  array_sockets.push(sock) # Add the socket to watching list
  # Accepted request with Thread
  Thread.new do # Thread for one socket session
      buf = ""
      while (true) do
        buf = sock.gets
        printf("(Server->%s:%s)Recv:[%s]\n",
            sock.peeraddr[2], sock.peeraddr[1], buf.inspect)
    
        # Break if the received data is nil(=socket is closed) or received "quit"
        break if (buf == nil)
        break if (buf.index("quit") == 0)
    
        # Reply
        output = buf
        printf("(Server->%s:%s)Sent:[%s]\n",
            sock.peeraddr[2], sock.peeraddr[1], output.inspect)
        array_sockets.each do |sock_reply| # Send back reply to all connected clients
          sock_reply.puts(output)
        end
      end
    
      # Closing socket if the session is terminated
      printf("(Server->%s:%s)Socket Closed\n",
          sock.peeraddr[2], sock.peeraddr[1])
      array_sockets.delete(sock) # Remove the socket from watching list
      sock.close
  end

end

s0.close
