# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dota2_arena_courier/version'

Gem::Specification.new do |spec|
  spec.name          = "dota2_arena_courier"
  spec.version       = Dota2ArenaCourier::VERSION
  spec.authors       = ["sebyx07"]
  spec.email         = ["gore.sebyx@yahoo.com"]
  spec.summary       = %q{Dota2 match/history parser}
  spec.description   = %q{Dota2 match/history parser}
  spec.homepage      = "https://github.com/sebyx07/dota2arena_courier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'typhoeus', '~> 0.6.9'
  spec.add_runtime_dependency 'gem_config', '~> 0.3.1'
  spec.add_development_dependency 'rspec', '~> 3.1.0'
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
