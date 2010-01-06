require 'pathname'
require 'test/unit'

require 'rack'
begin
  require 'ruby-debug'
  require 'redgreen'
  require 'phocus'
rescue LoadError, RuntimeError
end

$:.unshift Pathname(__FILE__).dirname.parent + 'lib'
require 'rack/supported_media_types'

class Test::Unit::TestCase
  def self.test(name, &block)
    define_method(:"test_#{name.gsub(/\s/,'_')}", &block)
  end
end

