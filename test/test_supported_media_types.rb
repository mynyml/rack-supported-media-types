require 'test/test_helper'

App = lambda {|env| [200, {'Content-Type' => 'text/html'}, ['content']] }
SMT = Rack::SupportedMediaTypes


# test: returns 406 Not Acceptable
app      = SMT.new(App, %w( application/xml application/json ))
response = Rack::MockRequest.new(app).get('/', 'HTTP_ACCEPT' => 'text/html')

assert { response.status == 406 }
assert { response.body.empty? }


# test: lets request through when media type is supported
app = SMT.new(App, %w( text/html application/xml ))
response = Rack::MockRequest.new(app).get('/', 'HTTP_ACCEPT' => 'text/html')

assert { response.status == 200 }


# test: requested type is assumed to be highest ranking type in Accept header's list
app = SMT.new(App, %w( text/html ))
client = Rack::MockRequest.new(app)

response = client.get('/', 'HTTP_ACCEPT' => 'text/html,application/xml')
assert { response.status == 200 }

response = client.get('/', 'HTTP_ACCEPT' => 'text/html;q=0.8,application/xml;q=0.9')
assert { response.status == 406 }


# test: matches wildcard media-range subtypes
app = SMT.new(App, %w( text/html application/json ))

begin
  response = Rack::MockRequest.new(app).get('/', 'HTTP_ACCEPT' => 'text/*')
  assert { response.status == 200 }
rescue Exception => e
  assert("Expected not to raise error, got:\n#{e.message}") { false }
end


# test: empty Accept header
app = SMT.new(App, %w( application/xml application/json ))

begin
  response = Rack::MockRequest.new(app).get('/', 'HTTP_ACCEPT' => '')
  assert { response.status == 406 }
rescue Exception => e
  assert("Expected not to raise error, got:\n#{e.message}") { false }
end

