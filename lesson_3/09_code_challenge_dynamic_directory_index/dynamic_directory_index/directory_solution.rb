require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubi'

get '/' do
  @files = Dir.glob('public/*').map { |file| File.basenmae(file) }.sort
  @files.reverse! if params[:sort] == 'desc'

  erb :home
end