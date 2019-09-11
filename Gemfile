# coding: utf-8
# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'bootstrap-datepicker-rails', '~> 1.6.4.1'
gem 'business_time', '~> 0.7.6'
gem 'carrierwave-aws', '~> 1.1.0'
gem 'coffee-rails', '~> 4.2.1'
gem 'devise', '~> 4.2.0'
gem 'enum_help', '~> 0.0.17'
gem 'faker', '~> 1.7.2'
gem 'figaro', '~> 1.1.1'
gem 'gretel', '~> 3.0.9'
gem 'haml-rails', '~> 0.9.0'
gem 'jbuilder', '~> 2.6.1'
gem 'jquery-rails', '~> 4.2.2'
gem 'kaminari', '~> 1.0.1'
gem 'less-rails', '~> 2.8.0'
gem 'mini_magick', '~> 4.6.0'
gem 'puma', '~> 3.6.2'
gem 'pundit', github: 'elabs/pundit'
gem 'rails', '~> 5.0.1'
gem 'ransack', '~> 1.8.2'
gem 'rolify', '~> 5.1.0'
gem 'sass-rails', '~> 5.0.6'
gem 'simple_form', '~> 3.4.0'
gem 'sprockets', '~> 3.6.3' # Use 3.6.x for avoid warnnings.
gem 'therubyracer', '~> 0.12.3'
gem 'turbolinks', '~> 5.0.1'
gem 'twitter-bootstrap-rails', '~> 3.2.2'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'uglifier', '~> 3.0.4'

group :production do
  gem 'pg', '~> 0.19.0'
end

group :development do
  gem 'listen', '~> 3.0.8'
  gem 'spring', '~> 2.0.1'
  gem 'spring-watcher-listen', '~> 2.0.1'
  gem 'web-console', '~> 3.4.0'
end

# Grouping development and test for emacs robe-mode completion.
group :development, :test do
  gem 'annotate', '~> 2.7.1'
  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'
  gem 'byebug', '~> 9.0.6', platform: :mri
  gem 'capybara', '~> 2.12.0'
  gem 'capybara-webkit', '~> 1.12.0'
  gem 'database_cleaner', '~> 1.5.3'
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'guard-rspec', '~> 4.7.3'
  gem 'launchy', '~> 2.4.3'
  gem 'letter_opener', '~> 1.4.1'
  gem 'pry-byebug', '~> 3.4.3'
  gem 'pry-doc', '~> 0.10.0'
  gem 'rspec-rails', '~> 3.5.2'
  gem 'selenium-webdriver', '~> 3.0.5'
  gem 'simplecov', '~> 0.13.0', require: false
  gem 'sqlite3', '~> 1.3.13'
  gem 'terminal-notifier-guard', '~> 1.7.0'
end

# Limit to test environment to avoid effect for generators.
group :test do
  gem 'timecop', '~> 0.8.1'
end
