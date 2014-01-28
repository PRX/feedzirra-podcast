# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'feedzirra-podcast/version'

Gem::Specification.new do |spec|
  spec.name          = "feedzirra-podcast"
  spec.version       = FeedzirraPodcast::VERSION
  spec.authors       = ["Chris Kalafarski"]
  spec.email         = ["chris@farski.com"]
  spec.description   = %q{Strict RSS 2 podcast parsing with Feedzirra}
  spec.summary       = %q{Feedzirra parser classes strictly for handling podcasts strictly}
  spec.homepage      = "https://github.com/PRX/feedzirra-podcast"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency("feedzirra")
  spec.add_dependency("periodic", "~> 1.2.2")
end
