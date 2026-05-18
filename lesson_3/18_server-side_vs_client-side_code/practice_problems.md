# `Gemfile`
Server-side. `Gemfile` prescribes the specific components of the software infrastructure on the server end. It is executed on the server.
LSBot: The `Gemfile` itself is not "executed" like Ruby code; instead, it is read by Bundler on the server to know which gems to install and load.

# `.rb`
Server-side. `.rb` files are the scripts that together make up the web application that runs on the server infrastructure. They are executed on the server.

# `.css`
Client-side. `.css` files are downloaded onto the client's machine and used by the browser to style the presentation of `.html` files.

# `.js`
Client-side. While I have not learned any JavaScript, my understanding so far is `.js` files are also downloaded onto the client's machine and run by the browser to enable complex user interactions with the website's front-end components. With that said, I am also aware that it is possible to build back-end, server-side applications with JavaScript, so in conclusion it depends on where the `.js` is and its intent.

# `.erb`
Server-side. `.erb` files enable the integration of Ruby code in the generation of HTML code. This enables Ruby web applications to pass processed data to the HTML file. The HTML code is then pacakaged into `.html` files and sent to the client.
LSBot: The `.erb` template is processed by Sinatra on the server. The Ruby code runs, and the result is plain HTML. Therefore, the resulting HTML is sent directly in the HTTP response body. It is not typically "packaged into `.html` files" on the client's disk first. The client browser simply receives HTML as text.