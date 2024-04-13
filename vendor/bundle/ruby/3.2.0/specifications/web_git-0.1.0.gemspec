# -*- encoding: utf-8 -*-
# stub: web_git 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "web_git".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Raghu Betina".freeze, "Jelani Woods".freeze]
  s.date = "2022-03-30"
  s.description = "WebGit is an embeddable Sinatra app that provides an in-browser visual interface to a simple but effective Git workflow. For educational purposes.".freeze
  s.email = ["raghu@firstdraft.com".freeze, "jelani@firstdraft.com".freeze]
  s.extra_rdoc_files = ["LICENSE.txt".freeze, "README.markdown".freeze]
  s.files = ["LICENSE.txt".freeze, "README.markdown".freeze]
  s.homepage = "http://github.com/firstdraft/web_git".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.4.6".freeze
  s.summary = "An in-browser Git GUI for your Rails project".freeze

  s.installed_by_version = "3.4.6" if s.respond_to? :installed_by_version

  s.specification_version = 4

  s.add_runtime_dependency(%q<actionview>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<ansispan>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<diffy>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<git>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<sinatra>.freeze, [">= 0"])
  s.add_runtime_dependency(%q<tzinfo-data>.freeze, [">= 0"])
  s.add_development_dependency(%q<juwelier>.freeze, ["~> 2.1.0"])
  s.add_development_dependency(%q<rdoc>.freeze, [">= 6.3.1"])
  s.add_development_dependency(%q<rspec>.freeze, ["~> 3.5.0"])
end
