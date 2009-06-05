# run me with:
#   $rackup examples/simple.ru -p 3000
#
# then point your browser to:
#   localhost:3000/
#   localhost:3000/foo
#
# and look for the server's output in the console (pay attention to status
# codes)
#
require 'pathname'
require 'rubygems'
require 'rack'

root = Pathname(__FILE__).dirname.parent.expand_path
require root + 'lib/rack/supported_media_types'

class App
  def call(env)
    [200, {'Content-Type' => 'text/html'}, ['now try <strong>/foo</strong> (will return 406)']]
  end
end

# given that the request comes from a webbrowser, and that it's Accept header's
# first value is text/html...

map '/' do
  # ... this will allow it through to the app
  use Rack::SupportedMediaTypes, %w( text/html application/xml )
  run App.new
end

map '/foo' do
  # ... this will abort the request and return 406 Not Acceptable
  use Rack::SupportedMediaTypes, %w( application/xml application/json )
  run App.new
end
