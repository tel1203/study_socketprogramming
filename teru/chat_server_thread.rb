# tcpserver program:
#   ruby chat_server_thread.rb <PORT#>
#  ex
#   ruby chat_server_thread.rb 12345

require "socket"

port = ARGV[0].to_i

s0 = TCPServer.open(port) # bind & listen

while (true) do
  # Waiting for new request
  printf("(Server)Socket Listening\n")
  sock = s0.accept
  printf("(Server->%s:%s)Socket Accepted:[%s]\n",
      sock.peeraddr[2], sock.peeraddr[1], sock.peeraddr.inspect)

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
        sock.puts(output)
      end
    
      # Closing socket if the session is terminated
      printf("(Server->%s:%s)Socket Closed\n",
          sock.peeraddr[2], sock.peeraddr[1])
      sock.close
  end

end

s0.close
