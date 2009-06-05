require 'test/test_helper'

App = lambda {|env| [200, {'Content-Type' => 'text/html'}, ['content']] }
SMT = Rack::SupportedMediaTypes

class SupportedMediaTypesTest < Test::Unit::TestCase

  test "returns 406 Not Acceptable" do
    app = SMT.new(App, %w( application/xml application/json ))

    response = Rack::MockRequest.new(app).get('/', 'HTTP_ACCEPT' => 'text/html')
    assert_equal 406, response.status
    assert response.body.empty?
  end

  test "lets request through when media type is supported" do
    app = SMT.new(App, %w( text/html application/xml ))

    response = Rack::MockRequest.new(app).get('/', 'HTTP_ACCEPT' => 'text/html')
    assert_equal 200, response.status
  end

  test "requested type is assumed to be first type in Accept header's list" do
    app = SMT.new(App, %w( text/html ))
    client = Rack::MockRequest.new(app)

    response = client.get('/', 'HTTP_ACCEPT' => 'text/html,application/xml')
    assert_equal 200, response.status

    response = client.get('/', 'HTTP_ACCEPT' => 'application/xml,text/html')
    assert_equal 406, response.status
  end

  test "ignores content-type params" do
    app = SMT.new(App, %w( application/xml application/json ))

    response = Rack::MockRequest.new(app).get('/', 'HTTP_ACCEPT' => 'application/xml;q=0.9')
    assert_equal 200, response.status
  end

  test "nil Accept header means all types accepted" do
    app = SMT.new(App, %w( application/xml application/json ))

    assert_nothing_raised do
      response = Rack::MockRequest.new(app).get('/', 'HTTP_ACCEPT' => nil)
      assert_equal 200, response.status
    end
  end

  test "empty Accept header" do
    app = SMT.new(App, %w( application/xml application/json ))

    assert_nothing_raised do
      response = Rack::MockRequest.new(app).get('/', 'HTTP_ACCEPT' => '')
      assert_equal 406, response.status
    end
  end
end
