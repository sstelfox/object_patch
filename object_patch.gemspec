# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'object_patch/version'

Gem::Specification.new do |spec|
  spec.name          = "object_patch"
  spec.version       = ObjectPatch::VERSION
  spec.authors       = ["Sam Stelfox"]
  spec.email         = ["sstelfox+gh@bedroomprogrammers.net"]
  spec.description   = %q{An implementation of JSON::Patch but for hashes and array. The results can be converted to JSON using the standard JSON library and the result will be a valid JSON::Patch.}
  spec.summary       = %q{An implementation of JSON::Patch but for hashes and array.}
  spec.homepage      = "http://stelfox.net/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.2"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
end
