# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "redd/version"

def gem_files
  `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
end

Gem::Specification.new do |spec|
  spec.name          = "redd"
  spec.version       = Redd::VERSION
  spec.authors       = ["Avinash Dwarapu"]
  spec.email         = ["avinash@dwarapu.me"]

  spec.summary       = "A powerful reddit API wrapper to craft powerful bots."
  spec.homepage      = "https://github.com/avidw/redd"
  spec.license       = "MIT"

  spec.files         = gem_files
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "multi_json", "~> 1.11"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "rubocop", "~> 0.37"

  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "factory_girl", "~> 4.5"
  spec.add_development_dependency "coveralls", "~> 0.8"
  spec.add_development_dependency "vcr", "~> 3.0"
  spec.add_development_dependency "webmock", "~> 1.22"
end
