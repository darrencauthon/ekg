# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ekg/version'

Gem::Specification.new do |spec|
  spec.name          = "ekg"
  spec.version       = Ekg::VERSION
  spec.authors       = ["Darren Cauthon", "Ferris Lucas"]
  spec.email         = ["darren@cauthon.com"]
  spec.description   = "Monitor the heartbeat of your app"
  spec.summary       = "Monitor the heartbeat of your app"
  spec.homepage      = "https://github.com/darrencauthon/ekg"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'subtle', '~>1.1.0'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'contrast'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "faraday"
end
