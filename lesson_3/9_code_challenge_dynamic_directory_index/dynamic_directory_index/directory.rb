require 'sinatra'
require 'sinatra/reloader'

get '/' do
  @sorting_order = params[:order] == 'descending' ? 'descending' : 'ascending'
  @files = Dir.glob('public/*')
  @files.reverse! if params[:order] == 'descending'

  erb :home
end