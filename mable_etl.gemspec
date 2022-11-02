# frozen_string_literal: true

require_relative "lib/mable_etl/version"

Gem::Specification.new do |spec|
  spec.name = "mable_etl"
  spec.version = MableEtl::VERSION
  spec.authors = ['Stacey Brosnan']
  spec.email = ['staceybrosnan@gmail.com']

  spec.summary = 'A Mable extractor - transformer - loader'
  spec.description = 'A Mable extractor - transformer - loader'
  spec.homepage = 'https://github.com/bettercaring/mable_etl.git/'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['allowed_push_host'] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  spec.add_runtime_dependency 'aws-sdk-s3', '~> 1'
  spec.add_runtime_dependency 'dry-validation'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rails'
  spec.add_development_dependency 'factory_bot'
  spec.add_development_dependency 'factory_bot_rails'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'sqlite3'

  spec.add_development_dependency 'database_cleaner-active_record'
end
