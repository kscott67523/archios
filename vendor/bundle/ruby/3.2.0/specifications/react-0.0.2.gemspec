# -*- encoding: utf-8 -*-
# stub: react 0.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "react".freeze
  s.version = "0.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kriss 'nu7hatch' Kowalik".freeze]
  s.date = "2010-08-17"
  s.description = "A simple application that allows for remote execution of commands.".freeze
  s.email = "kriss.kowalik@gmail.com".freeze
  s.executables = ["react".freeze]
  s.extra_rdoc_files = ["LICENSE".freeze, "README.md".freeze]
  s.files = ["LICENSE".freeze, "README.md".freeze, "bin/react".freeze]
  s.homepage = "http://github.com/nu7hatch/react".freeze
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.rubygems_version = "3.4.6".freeze
  s.summary = "Redis based remote command executor.".freeze

  s.installed_by_version = "3.4.6" if s.respond_to? :installed_by_version

  s.specification_version = 3

  s.add_development_dependency(%q<riot>.freeze, [">= 0.11.3"])
  s.add_runtime_dependency(%q<daemons>.freeze, [">= 0"])
end
