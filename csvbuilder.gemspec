# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv_builder/version'

Gem::Specification.new do |spec|
  spec.name          = "csvbuilder"
  spec.version       = Csvbuilder::VERSION
  spec.authors       = ["Stephen St. Martin"]
  spec.email         = ["steve@stevestmartin.com"]
  spec.description   = %q{CSV template handler using a Builder-style DSL}
  spec.summary       = %q{CSV template handler using a Builder-style DSL}
  spec.homepage      = ""
  spec.license       = "MIT"
  spec.required_ruby_version = '>= 1.9.3'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 3.0.0'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
