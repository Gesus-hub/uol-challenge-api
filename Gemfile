source "https://rubygems.org"

ruby '3.3.5'

# Rails standard gems
gem "rails",        "~> 8.0.1"
gem "puma",         ">= 5.0"
gem "tzinfo-data",  platforms: %i[ windows jruby ]

# Database
gem 'pg',                '~> 1.5.9'

group :development, :test do
  gem "debug",                  platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman",               require: false
  gem "rubocop-rails-omakase",  require: false
  gem "dotenv-rails",           "~> 3.1.4"
end
