require 'socket'

def find_path(str)
  result = ""
  str.split[1].chars.each do |char|
    break if char == "?"
    result << char
  end
  return result
end

def find_params(str)
  query_str = str.split[1]
  question_mark_idx = query_str.index('?')
  params_arr = query_str[(question_mark_idx + 1)..-1].split('&')
  params_vals_arr = params_arr.map { |param| param.split('=') }
  params_vals_arr.to_h
end

def roll_dice(num_sides)
  rand(num_sides) + 1
end

server = TCPServer.new("localhost", 3003)
loop do
  client = server.accept

  request_line = client.gets
  next if !request_line || request_line =~ /favicon/
  puts(request_line)

  p http_method = request_line[0, 3]
  p path = find_path(request_line)
  p params = find_params(request_line)

  client.puts("HTTP/1.1 200 OK")
  client.puts("Content-Type: text/plain\r\n\r\n")
  client.puts(request_line)

  if params.key?("rolls") && params["rolls"].to_i > 0
    num_sides = params["sides"].to_i
    num_rolls = params["rolls"].to_i
    num_rolls.times { client.puts(roll_dice(num_sides)) }
  end

  client.close
end