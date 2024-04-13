# -*- encoding: utf-8 -*-
# stub: grade_runner 0.0.9 ruby lib

Gem::Specification.new do |s|
  s.name = "grade_runner".freeze
  s.version = "0.0.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Raghu Betina".freeze, "Jelani Woods".freeze]
  s.date = "2023-11-20"
  s.description = "This gem runs your RSpec test suite and posts the JSON output to grades.firstdraft.com.".freeze
  s.email = ["raghu@firstdraft.com".freeze, "jelani@firstdraft.com".freeze]
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.markdown".freeze]
  s.files = ["LICENSE.txt".freeze, "README.markdown".freeze]
  s.homepage = "http://github.com/firstdraft/grade_runner".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.6".freeze
  s.summary = "A Ruby client for [firstdraft Grades](https://grades.firstdraft.com)".freeze

  s.installed_by_version = "3.4.6" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<activesupport>.freeze, [">= 2.3.5"])
  s.add_runtime_dependency(%q<oj>.freeze, ["~> 3.13.12"])
  s.add_runtime_dependency(%q<octokit>.freeze, ["~> 5.0"])
  s.add_runtime_dependency(%q<faraday-retry>.freeze, ["~> 1.0.3"])
  s.add_runtime_dependency(%q<rake>.freeze, ["~> 13"])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
  s.add_development_dependency(%q<rdoc>.freeze, ["~> 6.1"])
  s.add_development_dependency(%q<bundler>.freeze, ["~> 2.1.4"])
  s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
  s.add_development_dependency(%q<simplecov>.freeze, [">= 0"])
  s.add_development_dependency(%q<pry>.freeze, ["~> 0"])
  s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 3"])
  s.add_development_dependency(%q<pry-doc>.freeze, ["~> 0"])
  s.add_development_dependency(%q<pry-remote>.freeze, ["~> 0"])
  s.add_development_dependency(%q<pry-rescue>.freeze, ["~> 1"])
  s.add_development_dependency(%q<pry-stack_explorer>.freeze, ["~> 0"])
end
