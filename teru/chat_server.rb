# tcpserver program:
#   ruby chat_server.rb <PORT#>
#  ex
#   ruby chat_server.rb 12345

require "socket"

port = ARGV[0].to_i

s0 = TCPServer.open(port) # bind & listen

while (true) do
  # Waiting for new request
  printf("(Server)Socket Listening\n")
  sock = s0.accept
  printf("(Server)Socket Accepted:[%s]\n", sock.peeraddr.inspect)

  # Accepted request
  buf = ""
  while (true) do
    buf = sock.gets
    printf("(Server)Received:[%s]\n", buf.inspect)

    # Break if the received data is nil(=socket is closed) or received "quit"
    break if (buf == nil)
    break if (buf.index("quit") == 0)

    # Reply
    output = buf
    printf("(Server)Sent:[%s]@%s:%s\n", output.inspect, sock.peeraddr[2], sock.peeraddr[1])
    sock.puts(output)
  end

  # Closing socket if the session is terminated
  printf("(Server)Socket Closed\n")
  sock.close
end

s0.close
