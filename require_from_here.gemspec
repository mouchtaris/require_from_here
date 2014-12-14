# coding: utf-8

### See? Exactly why we need require_from_here.
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'require_from_here/version'

Gem::Specification.new do |spec|
  spec.name          = "require_from_here"
  spec.version       = RequireFromHere::VERSION
  spec.authors       = ["Nikos Mouchtaris"]
  spec.email         = ["mouchtaris@gmail.com"]
  spec.summary       = %q{require() files relative to the requiring file's directory}
  spec.description   = %q{require_from_here() requires files relative to the requiring file's directory, without any need to alter globally the LOAD_PATH.}
  spec.homepage      = "https://github.com/mouchtaris/require_from_here"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
