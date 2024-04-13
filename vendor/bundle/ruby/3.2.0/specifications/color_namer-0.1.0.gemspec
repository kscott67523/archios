# -*- encoding: utf-8 -*-
# stub: color_namer 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "color_namer".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["retro".freeze]
  s.date = "2010-10-01"
  s.description = "ColorNamer is a gem that allows you to name color from RGB value or from HTML hash. It will find the closest color and return a HTML hash, name and shade of that color.".freeze
  s.email = "konjevic@gmail.com".freeze
  s.extra_rdoc_files = ["LICENSE".freeze, "README.md".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze]
  s.homepage = "http://github.com/retro/color-namer".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "3.4.6".freeze
  s.summary = "ColorNamer can name your color from RGB value or HTML hash".freeze

  s.installed_by_version = "3.4.6" if s.respond_to? :installed_by_version

  s.specification_version = 3

  s.add_runtime_dependency(%q<color>.freeze, [">= 1.4.1"])
  s.add_development_dependency(%q<rspec>.freeze, [">= 1.2.9"])
end
