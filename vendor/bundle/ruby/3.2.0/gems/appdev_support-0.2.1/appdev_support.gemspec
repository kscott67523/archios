require_relative 'lib/appdev_support/version'

Gem::Specification.new do |spec|
  spec.name          = "appdev_support"
  spec.version       = AppdevSupport::VERSION
  spec.authors       = ["Jelani Woods"]
  spec.email         = ["jelani@firstdraft.com"]

  spec.summary       = %q{A gem that ties together the all the Rails monkey patches we use in class.}
  spec.description   = %q{🙈}
  spec.homepage      = "https://github.com/firstdraft/appdev_support"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/firstdraft/appdev_support"
  spec.metadata["changelog_uri"] = "https://github.com/firstdraft/appdev_support"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency(%q<tabulo>.freeze, [">= 0"])
end
