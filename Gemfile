# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in mable_etl.gemspec
gemspec

group :development, :test do
  gem 'pry', '~> 0.14.1'
end

gem 'rake', '~> 13.0'

gem 'rspec', '~> 3.0'

# code quality gems
group do
  gem 'rubocop-mable', git: 'https://github.com/bettercaring/rubocop-mable.git', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
