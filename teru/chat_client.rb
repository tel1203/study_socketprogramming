require 'socket'

host = ARGV[0]
port = ARGV[1]

sock = TCPSocket.open(host, port)

while (true) do
    message = STDIN.gets.to_s
    printf("(Client)SENT:[%s]\n", message.inspect)
    sock.puts(message)
    result = sock.gets
    printf("(Client)REPLY:[%s]\n", result.inspect)

    break if (result == nil)
end

sock.close()

