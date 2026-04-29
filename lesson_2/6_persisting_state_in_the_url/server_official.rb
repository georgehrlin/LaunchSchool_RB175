require 'socket'

def parse_request(request_line)
  http_method, path_and_params, http = request_line.split(' ')
  path, params = path_and_params.split('?')

  params = (params || '').split('&').each_with_object({}) do |pair, hash|
    key, value = pair.split('=')
    hash[key] = value
  end

  [http_method, path, params]
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  next unless request_line
  next if !request_line || request_line =~ /favicon/
  puts(request_line)

  http_method, path, params = parse_request(request_line)

  p http_method
  p path
  p params

  number = params["number"].to_i

  p number

  client.puts "HTTP/1.1 200 OK"
  client.puts "Content-Type: text/html"
  client.puts
  client.puts "<html>"
  client.puts "<body>"

  client.puts "<pre>"
  client.puts request_line
  client.puts http_method
  client.puts path
  client.puts params
  client.puts "</pre>"

  client.puts "<h1>Counter</h1>"

  client.puts "<p>The current number is #{number}.</p>"

  client.puts "<a href=\"http://localhost:3003/?number=#{number + 1}\">Add one</a>"
  client.puts "<a href=\"http://localhost:3003/?number=#{number - 1}\">Subtract one</a>"

  client.puts "</body>"
  client.puts "</html>"
  client.close
end