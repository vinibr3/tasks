source 'https://rubygems.org'

gem 'rails', '~> 8.0.3'
gem 'propshaft'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'jbuilder'
gem 'tzinfo-data', platforms: %i[ windows jruby ]
gem 'bootsnap', require: false
gem 'kamal', require: false
gem 'thruster', require: false
gem 'dotenv', '~> 3.2'

group :development, :test do
  gem 'debug', platforms: %i[ mri windows ], require: 'debug/prelude'
  gem 'brakeman', require: false
  gem 'rubocop-rails-omakase', require: false
end

group :development do
  gem 'web-console'
end

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'rswag'
  gem 'rswag-specs'
  gem 'spring'
  gem 'yard'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', require: false
  gem 'rspec', '~> 3.13'
  gem 'rspec-rails', '~> 7.1'
end
