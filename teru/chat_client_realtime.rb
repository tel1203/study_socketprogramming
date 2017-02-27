require 'socket'

host = ARGV[0]
port = ARGV[1]

sock = TCPSocket.open(host, port)

Thread.new do
  while (true) do
    result = sock.gets
    printf("(Client)RECV:[%s]\n", result.inspect)

    break if (result == nil)
  end
  sock.close()

  exit
end

while (true) do
    message = STDIN.gets.to_s
    printf("(Client)SENT:[%s]\n", message.inspect)
    sock.puts(message)
end


