# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nesta-plugin-automenu/version'

Gem::Specification.new do |gem|
  gem.name          = "nesta-plugin-automenu"
  gem.version       = Nesta::Plugin::AutoMenu::VERSION
  gem.authors       = ["paraqles"]
  gem.email         = ["paraqles@dthal.net"]
  gem.description   = %q{ With the help of this plugin for the NestaCMS it is possible to include a menu
containing links to all files in content.
Or it is possible to restrict the file discovery to a specific pattern.}
  gem.summary       = %q{Automatic Menu generation for the NesaCMS}
  gem.homepage      = "https://www.github.com/paraqles/nesta-plugin-automenu"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_dependency("nesta", ">= 0.9.11")
  gem.add_development_dependency("rake")
end
