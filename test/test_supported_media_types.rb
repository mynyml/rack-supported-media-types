require 'test/test_helper'

InnerApp = Rack::Builder.new {
  use Rack::Lint
  run lambda {|env| [200, {'Content-Type' => 'text/html'}, ['content']] }
}.to_app

class SupportedMediaTypeTest < Test::Unit::TestCase

  test "returns 415 Unsuported Media Type" do
    app = Rack::Builder.new {
      use Rack::SupportedMediaTypes, %w( application/xml text/html )
      run InnerApp
    }.to_app

    client = Rack::MockRequest.new(app)
    response = client.get('/', 'request.format' => '.txt')

    assert_equal 415, response.status
    assert response.body.empty?
  end

  test "lets request through when media type is supported" do
    app = Rack::Builder.new {
      use Rack::SupportedMediaTypes, %w( text/plain application/xml )
      run InnerApp
    }.to_app

    client = Rack::MockRequest.new(app)
    response = client.get('/', 'request.format' => '.txt')

    assert_equal 200, response.status
  end

  test "normalizes request format" do
    app = Rack::Builder.new {
      use Rack::SupportedMediaTypes, %w( text/html )
      run InnerApp
    }.to_app

    client = Rack::MockRequest.new(app)

    response = client.get('/', 'request.format' => 'html')
    assert_equal 200, response.status

    response = client.get('/', 'request.format' => 'text/html')
    assert_equal 200, response.status
  end
end
