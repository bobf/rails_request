# frozen_string_literal: true

require_relative 'lib/rails_request/version'

Gem::Specification.new do |spec|
  spec.name          = 'rails_request'
  spec.version       = RailsRequest::VERSION
  spec.authors       = ['Bob Farrell']
  spec.email         = ['git@bob.frl']

  spec.summary       = 'Rails request insight'
  spec.description   = 'Toolkit for replaying/analysing Rails requests'
  spec.homepage      = 'https://github.com/bobf/rails_request'
  spec.license       = 'MIT'

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  end

  spec.bindir        = 'bin'
  spec.executables   = []
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rails', '~> 6.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.85.1'
  spec.add_development_dependency 'strong_versions', '~> 0.4.4'
end
