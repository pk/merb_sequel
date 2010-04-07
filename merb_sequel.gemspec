#!/usr/bin/env gem build
# -*- encoding: utf-8 -*-

require 'date'
require 'lib/merb_sequel/version'

Gem::Specification.new do |gem|
  gem.name     = 'merb_sequel'
  gem.version  = Merb::Sequel::VERSION.dup
  gem.authors  = ['Wayne E. Seguin', 'Lance Carlson', 'Lori Holden', 'Pavel Kunc']
  gem.date     = Date.today.to_s
  gem.email    = 'wayneeseguin@gmail.com, lancecarlson@gmail.com, email@loriholden.com, pavel.kunc@gmail.com'
  gem.homepage = 'http://github.com/pk/merb_sequel'
  gem.summary  = 'Merb plugin that provides support for Sequel.'
  gem.description = gem.summary

  gem.has_rdoc = true 
  gem.require_paths = ['lib']
  gem.extra_rdoc_files = ['README.rdoc', 'LICENSE', 'TODO']
  gem.files = Dir['Rakefile', '{lib,spec}/**/*', 'README*', 'LICENSE*', 'TODO*'] & `git ls-files -z`.split("\0")

  gem.add_dependency('merb-core', '>= 1.1.0')
  gem.add_dependency('sequel', '>= 2.7.0')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('sqlite3-ruby')
  gem.add_development_dependency('webrat')
end
