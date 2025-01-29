# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.5'

# Rails standard gems
gem 'puma',         '>= 5.0'
gem 'rails',        '~> 8.0.1'
gem 'tzinfo-data',  platforms: %i[windows jruby]

# Database
gem 'pg', '~> 1.5.9'

group :development do
  gem 'rubocop',               '~> 1.71.0', require: false
  gem 'rubocop-factory_bot',   '~> 2.26.1', require: false
  gem 'rubocop-performance',   '~> 1.23.1', require: false
  gem 'rubocop-rails',         '~> 2.28.0', require: false
  gem 'rubocop-rspec',         '~> 3.4.0', require: false
  gem 'rubocop-rspec_rails',   '~> 2.30.0', require: false
end

group :development, :test do
  gem 'brakeman',               require: false
  gem 'debug',                  platforms: %i[mri windows], require: 'debug/prelude'
  gem 'dotenv-rails',           '~> 3.1.4'
  gem 'factory_bot_rails',      '~> 6.4.4'
  gem 'rspec-rails',            '~> 7.1.0'
  gem 'rubocop-rails-omakase',  require: false
end
