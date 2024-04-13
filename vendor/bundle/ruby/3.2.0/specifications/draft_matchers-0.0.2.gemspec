# -*- encoding: utf-8 -*-
# stub: draft_matchers 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "draft_matchers".freeze
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jelani Woods".freeze]
  s.date = "2023-05-30"
  s.description = "This gem adds wrappers around capybara/rspec matchers to improve error messages and expand available methods.".freeze
  s.email = "jelani@firstdraft.com".freeze
  s.homepage = "https://github.com/jelaniwoods/draft_matchers".freeze
  s.rubygems_version = "3.4.6".freeze
  s.summary = "More readable rspec matchers.".freeze

  s.installed_by_version = "3.4.6" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<capybara>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<color_namer>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<rspec>.freeze, [">= 0"])
end
