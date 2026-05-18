require "tilt/erubi"
require "sinatra"
require "sinatra/reloader"

def paragraphs_n_ids_with_query(chapter_number, query)
  content = File.read("data/chp#{chapter_number}.txt")
  results = []
  content.split("\n\n").each_with_index do |paragraph, paragraph_index|
    if paragraph.include?(query)
      results << {paragraph_id: (paragraph_index + 1), paragraph_content: paragraph}
    end
  end

  results
end

def each_chapter
  @contents.each_with_index do |chapter_name, index|
    chapter_number = index + 1
    contents = File.read("data/chp#{chapter_number}.txt")
    yield chapter_number, chapter_name, contents
  end
end

def chapters_matching(query)
  results = []

  return results if !query || query.empty?

  each_chapter do |chapter_number, chapter_name, contents|
    results << {chapter_number: chapter_number, chapter_name: chapter_name} if contents.include?(query)
  end

  results
end

helpers do
  def in_paragraphs(content)
    paragraph_number = 0
    content.split("\n\n").map do |paragraph|
      paragraph_number += 1
      "<p id=\"#{paragraph_number}\">#{paragraph}</p>"
    end.join
  end

  def format_search_result_chapters(chapter_numbers, toc)
    return "<p>Sorry, no matches were found.</p>" if chapter_numbers.empty?
    result = chapter_numbers.map do |chapter_number|
      "<li><a href=\"/chapter/#{chapter_number}\">#{toc[chapter_number - 1]}</a></li>"
    end.join
    "<ul>\n\s\s#{result}\n\s\s</ul>"
  end

  def format_search_result_paragraphs(chapter_number, query)
    paragraphs_n_ids_with_query(chapter_number, query).map do |result|
      "<li><a href=\"/chapters/#{chapter_number}\##{result[:paragraph_id]}\">#{highlight_search_keyword(result[:paragraph_content], query)}</a></li>"
    end.join
  end

  def highlight_search_keyword(str, keyword)
    str.sub(keyword) { |match| "<strong>#{keyword}</strong>"}
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
  @results = chapters_matching(params[:query])
  erb :search
end

not_found do
  redirect "/"
end
