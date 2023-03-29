source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby ">= 3.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Add support for gopher to `Net::` and `URI::`
gem "ruby-net-text", "~> 0.0.7"

# Add support for view decorators
gem "draper", "~> 4.0.2"

# Use marcel to work out file types
gem "marcel", "~> 1.0.2"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]

  # Use .env file
  gem "dotenv-rails"

  # Use rspec for testing
  gem "rspec-rails"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Use rubocop to enforce good coding practices
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "pry"
  gem "selenium-webdriver"
  gem "webdrivers"
end
