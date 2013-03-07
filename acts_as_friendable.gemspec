# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'acts_as_friendable/version'

Gem::Specification.new do |spec|
  spec.name          = "acts_as_friendable"
  spec.version       = ActsAsFriendable::VERSION
  spec.authors       = ["Jeremy Ward"]
  spec.email         = ["jrmy.ward@gmail.com"]
  spec.description   = %q{ActsAsFriendable provides a Friendship model, relevent scopes, and many instance methods to quickly and easily add Social Networking functionality to your Rails application.}
  spec.summary       = %q{A drop-in solution to add Friendship functionality to a Rails application.}
  spec.homepage      = "https://github.com/jrmyward/acts_as_friendable"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rails', '~> 3.0'
  spec.add_development_dependency 'sqlite3'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'ammeter'
  spec.add_development_dependency "database_cleaner"
end
