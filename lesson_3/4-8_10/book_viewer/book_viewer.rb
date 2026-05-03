require "tilt/erubi"
require "sinatra"
require "sinatra/reloader"

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  @contents = File.readlines("data/toc.txt")

  erb :home
end

get "/chapters/1" do
  @title = "Chapter 1: A Scandal in Bohemia"
  @contents = File.readlines("data/toc.txt")
  @content = File.read("data/chp1.txt").split("\n\n")

  erb :chapter
end
