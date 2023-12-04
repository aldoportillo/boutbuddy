source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "ransack"
gem "cloudinary"
gem "httparty"
gem "simple_form"

gem "rails_admin", "~> 3.1"
gem "sassc-rails"
gem 'rake', '13.1.0'

gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "sprockets-rails"

gem "chartkick"
gem "pg", "~> 1.1"

gem "puma", "~> 5.0"

gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem "rails_live_reload"

  gem "nokogiri"
  
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# AppDev Gems
# ===========
gem "appdev_support"
gem "awesome_print"
gem "devise"       # to be removed
gem "dotenv-rails"
gem "faker"
gem "htmlbeautifier"
gem "http"

gem "table_print"
gem "sassc-rails"

group :development do
  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "draft_generators"
  gem "grade_runner"
  gem "pry-rails"
  gem "rails_db"
  gem "rails-erd"
  gem "rufo"
  gem "specs_to_readme"
  gem "web_git"
end

group :development, :test do
  gem "rspec-rails", "~> 6.0.0"
end

group :test do
  gem "draft_matchers"#, "0.0.2"#path: "../../my_stuff/draft_matchers"
  # gem "draft_matchers"
  gem "rspec-html-matchers"
  gem "webmock"
end
