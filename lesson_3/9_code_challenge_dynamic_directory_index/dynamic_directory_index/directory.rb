require 'sinatra'
require 'sinatra/reloader'

get '/' do
  @sorting_is_descending = params[:order]
  @files = Dir.glob('public/*')
  @files.reverse! if @sorting_is_descending

  erb :home
end