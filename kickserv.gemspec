
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kickserv/version'

Gem::Specification.new do |spec|
  spec.name          = 'kickserv'
  spec.version       = Kickserv::VERSION
  spec.authors       = ['Customer Lobby']
  spec.email         = ['dev@customerlobby.com']

  spec.summary       = 'Client for the Kickserv API'
  spec.description   = 'Client for the Kickserv API'
  spec.homepage      = ''
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency('byebug')
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency('activesupport')
  spec.add_runtime_dependency('faraday')
  spec.add_runtime_dependency('faraday_middleware')
  spec.add_runtime_dependency('hashie')
  spec.add_runtime_dependency('nokogiri')
  spec.add_runtime_dependency('vcr')
end
