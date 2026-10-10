require_relative "lib/standard/studio/version"

Gem::Specification.new do |spec|
  spec.name = "standard-studio"
  spec.version = Standard::Studio::VERSION
  spec.authors = ["ITSUSSTUDIO"]
  spec.email = ["mackenzie@itsusstudio.com"]

  spec.summary = "ITSUSSTUDIO rules for Standard Ruby"
  spec.description = "The studio's lint stack in one gem: Standard, its Rails plugin, the factory_bot and rake cops, and the studio's own rules."
  spec.homepage = "https://github.com/itsusstudio/standard-studio"
  spec.required_ruby_version = ">= 3.3"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["default_lint_roller_plugin"] = "Standard::Studio::Plugin"

  spec.files = Dir["lib/**/*.rb", "config/*.yml", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency "lint_roller", "~> 1.0"
  spec.add_dependency "rubocop", ">= 1.72"
  spec.add_dependency "rubocop-factory_bot", ">= 2.27"
  spec.add_dependency "rubocop-rake", ">= 0.7"
  spec.add_dependency "standard", ">= 1.50"
  spec.add_dependency "standard-rails", ">= 1.3"
end
