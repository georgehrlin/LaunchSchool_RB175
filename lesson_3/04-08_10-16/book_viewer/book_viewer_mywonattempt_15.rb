require "tilt/erubi"
require "sinatra"
require "sinatra/reloader"

helpers do
  def in_paragraphs(str)
    str.split("\n\n").map do |paragraph|
      "<p>#{paragraph}</p>"
    end.join
  end

  def format_search_result_chapters(chapter_numbers, toc)
    return "<p>Sorry, no matches were found.</p>" if chapter_numbers.empty?
    result = chapter_numbers.map do |chapter_number|
      "<li><a href=\"/chapter/#{chapter_number}\">#{toc[chapter_number - 1]}</a></li>"
    end.join
    "<ul>\n\s\s#{result}\n\s\s</ul>"
  end
end

before do
  @contents = File.readlines("data/toc.txt")
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"

  erb :home
end

get "/chapters/:number" do
  @chapter_number = params[:number].to_i
  @title = "Chapter #{ @chapter_number }: #{ @contents[@chapter_number - 1] }"

  redirect "/" unless (1..@contents.size).cover?(@chapter_number)

  @chapter_content = File.read("data/chp#{@chapter_number}.txt")

  erb :chapter
end

get "/search/?" do
  keyword = params[:query]
  @search_result_chapter_numbers = 
    (1..@contents.size).to_a.filter do |chapter_number|
      chapter_content = File.read("data/chp#{chapter_number}.txt")
      chapter_content.downcase.include?(keyword)
    end

  erb :search
end

not_found do
  redirect "/"
end