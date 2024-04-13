# -*- encoding: utf-8 -*-
# stub: appdev_support 0.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "appdev_support".freeze
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "changelog_uri" => "https://github.com/firstdraft/appdev_support", "homepage_uri" => "https://github.com/firstdraft/appdev_support", "source_code_uri" => "https://github.com/firstdraft/appdev_support" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jelani Woods".freeze]
  s.bindir = "exe".freeze
  s.date = "2023-05-30"
  s.description = "\u{1F648}".freeze
  s.email = ["jelani@firstdraft.com".freeze]
  s.homepage = "https://github.com/firstdraft/appdev_support".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.3.0".freeze)
  s.rubygems_version = "3.4.6".freeze
  s.summary = "A gem that ties together the all the Rails monkey patches we use in class.".freeze

  s.installed_by_version = "3.4.6" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<tabulo>.freeze, [">= 0"])
end
