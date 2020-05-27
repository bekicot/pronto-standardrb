# -*- encoding: utf-8 -*-

$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'pronto/standardrb/version'
require 'English'

Gem::Specification.new do |s|
  s.name = 'pronto-standardrb'
  s.version = Pronto::StandardrbVersion::VERSION
  s.platform = Gem::Platform::RUBY
  s.author = 'Yana Agun Siswanto'
  s.email = 'yana.developer@gmail.com'
  s.homepage = 'http://github.com/bekicot/pronto-standardrb'
  s.summary = 'Pronto runner for Standardrb, ruby code analyzer'

  s.licenses = ['MIT']
  s.required_ruby_version = '>= 2.3.0'
  s.rubygems_version = '1.8.23'

  s.files = `git ls-files`.split($RS).reject do |file|
    file =~ %r{^(?:
    spec/.*
    |Gemfile
    |Rakefile
    |\.rspec
    |\.gitignore
    |\.rubocop.yml
    |\.travis.yml
    )$}x
  end
  s.test_files = []
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.require_paths = ['lib']

  s.add_runtime_dependency('pronto', '~> 0.10.0')
  s.add_runtime_dependency('standard', '~> 0.4.6')
  s.add_development_dependency('rake', '~> 12.0')
  s.add_development_dependency('rspec', '~> 3.4')
  s.add_development_dependency('rspec-its', '~> 1.2')
end
