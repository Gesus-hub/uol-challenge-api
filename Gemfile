# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.5'

# Rails standard gems
gem 'puma',         '>= 5.0'
gem 'rails',        '~> 8.0.1'
gem 'tzinfo-data',  platforms: %i[windows jruby]

# Database
gem 'pg',                '~> 1.5.9'
gem 'strong_migrations', '~> 2.1.0'

# Tools
gem 'discard',     '~> 1.4.0'
gem 'graphql',     '~> 2.4'
gem 'propshaft', '~> 0.6.0'

group :development do
  gem 'graphiql-rails',        '~> 1.8'
  gem 'rubocop',               '~> 1.71.0', require: false
  gem 'rubocop-factory_bot',   '~> 2.26.1', require: false
  gem 'rubocop-performance',   '~> 1.23.1', require: false
  gem 'rubocop-rails',         '~> 2.29.1', require: false
  gem 'rubocop-rspec',         '~> 3.4.0', require: false
  gem 'rubocop-rspec_rails',   '~> 2.30.0', require: false
end

group :development, :test do
  gem 'brakeman',               require: false
  gem 'debug',                  platforms: %i[mri windows], require: 'debug/prelude'
  gem 'dotenv-rails',           '~> 3.1.4'
  gem 'factory_bot_rails',      '~> 6.4.4'
  gem 'faker',                  '~> 3.5.1'
  gem 'pry-byebug',             '~> 3.10'
  gem 'pry-rails',              '~> 0.3.11'
  gem 'rspec-rails',            '~> 7.1.0'
  gem 'rubocop-rails-omakase',  require: false
  gem 'shoulda-matchers',       '~> 6.4.0', require: false
end
