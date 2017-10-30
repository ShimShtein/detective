# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'detective/version'

Gem::Specification.new do |spec|
  spec.name          = 'detective'
  spec.version       = Detective::VERSION
  spec.authors       = ["Shimon Shtein\n"]
  spec.email         = ['sshtein@redhat.com']

  spec.summary       = 'Sinatra wrapper for rubocop with custom rules'
  spec.description   = <<-DESCRIPTION
  This gem simplifies work with rubocop to inspect files using custom rules.
  It enables also inspection of .erb templates.
  DESCRIPTION
  spec.homepage      = 'https://github.com/ShimShtein/detective'
  spec.license       = 'LGPL-3.0'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables   = ['detective']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'

  spec.add_dependency 'rubocop', '~> 0.50.0'
  spec.add_dependency 'sinatra'
end
