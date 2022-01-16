# frozen_string_literal: true

require_relative "lib/double_loop"

Gem::Specification.new do |spec|
  spec.name = "doubleloop-ruby"
  spec.version = DoubleLoop::VERSION
  spec.authors = ["DoubleLoop Engineering"]
  spec.email = ["engineering@doubleloop.app"]

  spec.summary = "Interact with DoubleLoop's API"
  spec.description = "This gem provides an interface to interact with DoubleLoop's API "\
                     "(https://app.doubleloop.app/apidocs/1.0.html)"
  spec.homepage = "https://github.com/doubleloopapp/doubleloop-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/doubleloopapp/doubleloop-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/doubleloopapp/doubleloop-ruby/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "webmock"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
