Gem::Specification.new do |s|
  s.name                = 'rack-supported-media-types'
  s.version             = "0.9.3"
  s.summary             = "Rack middleware to specify an app's supported media types."
  s.description         = "Rack middleware to specify an app's supported media types. Returns '406 Not Acceptable' status when unsuported type is requested."
  s.author              = "mynyml"
  s.email               = "mynyml@gmail.com"
  s.homepage            = "http://github.com/mynyml/rack-supported-media-types"
  s.rubyforge_project   = "rack-supported-media-types"
  s.has_rdoc            =  false
  s.require_path        = "lib"
  s.files               =  File.read("Manifest").strip.split("\n")

  s.add_dependency 'rack-accept-media-types', '>= 0.6'
  s.add_development_dependency 'rack'
end

