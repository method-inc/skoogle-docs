# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "skoogle_docs/version"

Gem::Specification.new do |spec|
  spec.name          = "skoogle_docs"
  spec.version       = SkoogleDocs::VERSION
  spec.authors       = ["Dustan Kasten", "Enrique Gonzalez"]
  spec.email         = ["dustan@skookum.com"]
  spec.summary       = "A gem for requesting and transforming Google Docs."
  spec.description   = ""
  spec.homepage      = "www.skookum.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "webmock", "~> 1.20"

  spec.add_dependency "google-api-client", "~> 0.7"
  spec.add_dependency "nokogiri", "~> 1.6"
end
