# install required dependency:
#   $ gem install rack-abstract-format
#
# run with:
#   $ rackup examples/recommended.ru -p 3000
#
# and point your web browser to:
#   localhost:3000/foo.html
#
require 'pathname'
require 'rack'
require 'rack/abstract_format'

$:.unshift(Pathname(__FILE__).dirname.parent + 'lib')
require 'rack/supported_media_types'

class App
  def call(env)
    body = <<-BODY
<pre>
try using extensions:

  - /foo.html
  - /foo.xml
  - /foo.json
  - /foo.txt
  - ...

app will only accept html and xml requests. others will return 406 (check
server's output in console to see it).
</pre>
    BODY
    [200, {'Content-Type' => 'text/html'}, [body]]
  end
end

use Rack::AbstractFormat
use Rack::SupportedMediaTypes, %w( text/html application/xml )
run App.new

