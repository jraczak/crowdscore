source 'http://rubygems.org'

gem 'rails', '3.1.0'

gem "pg"
gem "inherited_resources"
gem "slim"
gem "slim-rails"
gem "devise", :git => "git://github.com/heimidal/devise.git", :branch => "updates"
gem "cancan"
gem "thin"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

gem "rails-erd", :group => :development

group :development, :test do
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem "pry"
  gem "rspec-rails", "~> 2.6.0"
  gem 'heroku'
  gem "pickle"
  gem "rails3-generators"
end

group :test do
  gem "cucumber-rails"
  gem "factory_girl_rails"
  gem "capybara", "~> 1.1.0"
  gem "database_cleaner"
  gem "timecop"
  gem "shoulda", "~> 3.0.0.beta2"
  gem "launchy"
  gem "email_spec"
end
