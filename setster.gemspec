# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'setster/version'

Gem::Specification.new do |spec|
  spec.name          = 'setster'
  spec.version       = Setster::VERSION
  spec.authors       = ['Boyoung Kwon', 'Kevin Pheasey']
  spec.email         = ['boyoung.kwon@gmail.com', 'kevin.pheasey@gmail.com']
  spec.summary       = %q{Setster API wrapper.}
  spec.description   = %q{Setster API wrapper.}
  spec.homepage      = 'https://github.com/bokwon/setster'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.13.0'
end
