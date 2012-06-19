# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "guerrilla_patch"
  s.version = "2.6.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["drKreso"]
  s.date = "2012-06-19"
  s.description = "I am tierd of hunting down monkey patches at large. Caging them inside this gem"
  s.email = "kresimir.bojcic@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "guerrilla_patch.gemspec",
    "lib/guerrilla_patch.rb",
    "lib/guerrilla_patch/allocate.rb",
    "lib/guerrilla_patch/kernel.rb",
    "lib/guerrilla_patch/string.rb",
    "spec/guerrilla_patch/allocate_spec.rb",
    "spec/guerrilla_patch/kernel_spec.rb",
    "spec/guerrilla_patch/string_spec.rb"
  ]
  s.homepage = "http://github.com/drkreso/guerrilla_patch"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Collection of monkey patches"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

