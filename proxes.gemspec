# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proxes/version'

Gem::Specification.new do |spec|
  spec.name          = 'proxes'
  spec.version       = ProxES::VERSION
  spec.authors       = ['Jurgens du Toit']
  spec.email         = ['jrgns@jadeit.co.za']

  spec.summary       = %q{Rack wrapper around Elasticsearch to provide security and management features}
  spec.description   = %q{Rack wrapper around Elasticsearch to provide security and management features}
  spec.homepage      = 'https://github.com/eagerelk/proxes'
  spec.license       = 'LGPLv3'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rake'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'guard-shotgun'

  spec.add_dependency 'rack_csrf'
  spec.add_dependency 'rack-proxy'
  spec.add_dependency 'roda'
  spec.add_dependency 'elasticsearch'
  spec.add_dependency 'logger'
  spec.add_dependency 'pundit'
  spec.add_dependency 'sequel'
  spec.add_dependency 'bcrypt'
  spec.add_dependency 'omniauth'
  spec.add_dependency 'omniauth-identity'
  spec.add_dependency 'warden'
  spec.add_dependency 'jwt'
  spec.add_dependency 'haml'
  spec.add_dependency 'tilt', '>= 2'
end
