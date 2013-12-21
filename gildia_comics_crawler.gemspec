# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gildia_comics_crawler/version'

Gem::Specification.new do |spec|
  spec.name          = "gildia_comics_crawler"
  spec.version       = GildiaComicsCrawler::VERSION
  spec.authors       = ["Jan Jędrychowski"]
  spec.email         = ["jan@jedrychowski.org"]
  spec.description   = "Crawler for downloading comics from komiks.gildia.pl"
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "nokogiri"
end
