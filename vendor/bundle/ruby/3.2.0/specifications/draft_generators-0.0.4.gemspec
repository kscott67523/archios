# -*- encoding: utf-8 -*-
# stub: draft_generators 0.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "draft_generators".freeze
  s.version = "0.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Raghu Betina".freeze]
  s.date = "2023-05-30"
  s.description = "This is a set of generators that help beginners learn to program. Primarily, they generate code that is more explicit and verbose and less idiomatic and \u201Cmagical\u201D than the built-in scaffold generator, which is helpful for beginners while they are learning how exactly things are wired together.".freeze
  s.email = "raghu@firstdraft.com".freeze
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.markdown".freeze]
  s.files = ["LICENSE.txt".freeze, "README.markdown".freeze]
  s.homepage = "http://github.com/raghubetina/draft_generators".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.6".freeze
  s.summary = "Generators that help beginners learn to program.".freeze

  s.installed_by_version = "3.4.6" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<indefinite_article>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<devise>.freeze, [">= 0"])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
  s.add_development_dependency(%q<rdoc>.freeze, ["~> 3.12"])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 1.0"])
  s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
  s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
end
