require 'pathname'

require 'rack'
require 'nanotest'
begin
  require 'ruby-debug'
  require 'redgreen'
  require 'nanotest/stats'
  require 'nanotest/focus'
rescue LoadError, RuntimeError
end

$:.unshift Pathname(__FILE__).dirname.parent + 'lib'
require 'rack/supported_media_types'

include Nanotest

