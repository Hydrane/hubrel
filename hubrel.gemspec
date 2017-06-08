# coding: utf-8

lib = File.expand_path('../libraries', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hubrel_version'

Gem::Specification.new do |spec|
  spec.name          = 'hubrel'
  spec.version       = Hubrel::VERSION
  spec.authors       = ['Robert Veznaver']
  spec.email         = ['rv@bidmotion.com']

  spec.summary       = 'Ruby gem for a highly-opinionated GitHub release workflow.'
  spec.homepage      = 'https://github.com/Hydrane/hubrel'

  # make sure Chef files do not end up in the Gem
  spec.files         = Dir['libraries/*'] + %w[README.md LICENSE]
  spec.require_paths = ['libraries']

  # only gems present in Chef may be added as runtime dependencies
  spec.add_development_dependency 'rspec'
end
