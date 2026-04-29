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

str= "GET /?rolls=2&sides=6 HTTP/1.1"

p find_params(str)