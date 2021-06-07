# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'circuits/version'

Gem::Specification.new do |spec|
  spec.name                  = 'circuits'
  spec.version               = Circuits::VERSION
  spec.authors               = ['Henry Muru Paenga']
  spec.email                 = ['meringu@gmail.com']
  spec.summary               = 'Express logical circuits in code'
  spec.homepage              = 'https://github.com/meringu/circuits'
  spec.license               = 'MIT'
  spec.required_ruby_version = '~> 3.0'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2'
  spec.add_development_dependency 'coveralls', '~> 0.8'
  spec.add_development_dependency 'rake', '~> 13'
  spec.add_development_dependency 'rspec', '~> 3'
  spec.add_development_dependency 'rubocop', '~> 1'
  spec.add_development_dependency 'yard', '~> 0.9.26'
end
