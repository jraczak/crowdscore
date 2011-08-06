source 'http://rubygems.org'

gem 'rails', '3.1.0.rc5'

gem "pg"
gem "inherited_resources"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0.rc"
  gem 'coffee-rails', "~> 3.1.0.rc"
  gem 'uglifier'
end

gem 'jquery-rails'

group :development, :test do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem "rspec-rails", "~> 2.6.0"
  gem "ruby-debug19", :platforms => :mri_19
  gem 'heroku'
  gem "pickle"
  gem "rails3-generators"
end

group :test do
  gem "cucumber-rails"
  gem "factory_girl_rails"
  gem "capybara"
  gem "database_cleaner"
  gem "timecop"
  gem "shoulda"
  gem "launchy"
  gem "capybara-webkit"
end
