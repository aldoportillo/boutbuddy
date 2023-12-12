source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# Core Rails Gems
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "puma", "~> 5.0"
gem "pg", "~> 1.1"
gem "sprockets-rails"
gem "importmap-rails"

# Hotwire & Stimulus
gem "turbo-rails"
gem "stimulus-rails"
gem "pundit"
# Redis & Kredis
gem "redis", "~> 4.0"
# gem "kredis"

# Active Model & Storage
# gem "bcrypt", "~> 3.1.7"
# gem "image_processing", "~> 1.2"

# Utilities
gem "bootsnap", require: false
gem "cloudinary"
gem "dotenv-rails"
gem "faker"
gem "http"
gem "httparty"
gem "jbuilder"
gem "ransack"
gem "simple_form"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Data Visualization & Admin
gem "chartkick"
gem "rails_admin", "~> 3.1"

# Styling
gem "sassc-rails"

# Background Jobs
gem "good_job"

# Scheduler
gem "whenever"

# Development & Testing Tools
group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails", "~> 6.0.0"
end

group :development do
  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "draft_generators"
  gem "grade_runner"
  gem "nokogiri"
  gem "pry-rails"
  gem "rails_db"
  gem "rails-erd"
  gem "rails_live_reload"
  gem "rufo"
  gem "specs_to_readme"
  gem "web-console"
  gem "web_git"
  # gem "rack-mini-profiler"
  # gem "spring"
end

group :test do
  gem "capybara"
  gem "draft_matchers"
  gem "rspec-html-matchers"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "webmock"
end

# AppDev Gems
gem "appdev_support"
gem "awesome_print"
gem "devise"       # to be removed
gem "htmlbeautifier"
gem "table_print"

# Cleanup and maintenance gems
gem "rake", '13.1.0'
