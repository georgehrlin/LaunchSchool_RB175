require 'rackup'

class MyApp
  def call(env)
    ['200', { "Content-Type" => "text/PLAIN" }, ["hello world"]]
  end
end

Rackup::Handler::WEBrick.run MyApp.new