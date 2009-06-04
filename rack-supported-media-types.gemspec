--- !ruby/object:Gem::Specification 
name: rack-supported-media-types
version: !ruby/object:Gem::Version 
  version: "0.9"
platform: ruby
authors: 
- Martin Aumont
autorequire: 
bindir: bin
cert_chain: []

date: 2009-06-04 00:00:00 -04:00
default_executable: 
dependencies: []

description: Rack middleware to specify an app's supported media types. Returns '415 Unsuported Media Type' status when unsuported type is requested.
email: mynyml@gmail.com
executables: []

extensions: []

extra_rdoc_files: []

files: 
- Rakefile
- test
- test/test_supported_media_types.rb
- test/test_helper.rb
- examples
- examples/simple.ru
- examples/recommended.ru
- lib
- lib/rack
- lib/rack/supported_media_types.rb
- LICENSE
- rack-supported-media-types.gemspec
- README
has_rdoc: true
homepage: ""
licenses: []

post_install_message: 
rdoc_options: []

require_paths: 
- lib
required_ruby_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
required_rubygems_version: !ruby/object:Gem::Requirement 
  requirements: 
  - - ">="
    - !ruby/object:Gem::Version 
      version: "0"
  version: 
requirements: []

rubyforge_project: 
rubygems_version: 1.3.3
signing_key: 
specification_version: 3
summary: Rack middleware to specify an app's supported media types.
test_files: []

