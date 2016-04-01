# -*- encoding: utf-8 -*-

$:.push File.expand_path("../lib", __FILE__)
require "guerrilla_patch/version"

Gem::Specification.new do |gem|
  gem.authors       = ["drKreso"]
  gem.email         = ["kresimir.bojcic@gmail.com"]
  gem.description = "Collection of monkey patches I like to use in my projects"
  gem.summary = "Since I am tired of hunting down monkey patches at large I am caging them inside this gem"
  gem.homepage = "http://github.com/drKreso/guerrilla_patch"
  gem.date = "2016-04-01"


  gem.licenses = ["MIT"]
  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "guerrilla_patch"
  gem.require_paths = ["lib"]
  gem.version = GuerrillaPatch::VERSION

end
