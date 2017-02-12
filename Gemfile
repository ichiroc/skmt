# coding: utf-8
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.1'
# Use sqlite3 as the database for Active Record
gem 'sqlite3', "~> 1.3.13"
# Use Puma as the app server
gem 'puma', '~> 3.6.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 3.0.4'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.1'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', "~> 4.2.2"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.0.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.6.1'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', "~> 9.0.6", platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '~> 3.4.0'
  gem 'listen', '~> 3.0.8'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring', "~> 2.0.1"
  gem 'spring-watcher-listen', '~> 2.0.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'business_time'
gem 'bootstrap-datepicker-rails'
gem 'carrierwave'
gem 'devise', "~> 4.2.0"
gem 'rolify', "~> 5.1.0"
gem 'pundit', github: 'elabs/pundit'
gem 'haml-rails', "~> 0.9.0"
gem 'kaminari', "~> 1.0.1"
gem 'mini_magick'
gem 'simple_form', "~> 3.4.0"
gem 'twitter-bootstrap-rails', "~> 3.2.2"
group :development, :test do
  gem 'annotate', "~> 2.7.1"
  gem 'better_errors', "~> 2.1.1"
  gem 'binding_of_caller', "~> 0.7.2"
  gem 'capybara', "~> 2.12.0"
  gem 'capybara-webkit', "~> 1.12.0"
  gem 'database_cleaner', "~> 1.5.3"
  gem 'factory_girl_rails', "~> 4.8.0"
  gem 'faker', "~> 1.7.2"
  gem 'guard-rspec', "~> 4.7.3"
  gem 'launchy', "~> 2.4.3"
  gem 'letter_opener', "~> 1.4.1"
  gem 'pry-byebug', "~> 3.4.2"
  gem 'pry-doc', "~> 0.10.0"
  gem 'rspec-rails', "~> 3.5.2"
  gem 'selenium-webdriver', "~> 3.0.5"
  gem 'terminal-notifier-guard'
end

gem 'therubyracer', "~> 0.12.3"
gem 'less-rails'

# 警告抑止のため
gem "sprockets", '3.6.3'
