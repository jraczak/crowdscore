source 'http://rubygems.org'

gem 'rails', '3.2.2'

gem "pg"
gem "inherited_resources"
gem "slim-rails"
#gem "devise", "~> 2.1.0"
gem "devise" #, "~> 3.0.0"
gem "cancan"
gem "thin"
gem "carrierwave"
gem "rmagick", "~> 2.13.2"
gem "fog", "~> 1.3.1"

gem "will_paginate", "~> 3.0.0"
gem "state_select", git: "git://github.com/jraczak/state_select.git"
#git: "git@github.com:heimidal/state_select.git"
gem "acts_as_audited", "2.0.0"
gem "airbrake"
gem "sunspot_rails"
gem "geocoder"
gem "rails-backbone", "~> 0.7.0"
gem "ejs"
gem "omniauth-facebook"
gem "gmaps4rails", "~> 1.5.6"
gem "merit"
gem "sunspot_solr", "~> 2.1.0"
gem "devise_invitable", "~> 1.1.0"
gem 'aws-sdk'
gem 'factual-api'
gem 'bourbon'
gem 'font-awesome-rails'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', ">= 1.0.3"
  #gem "font-awesome-rails"
  #gem 'bourbon'
end

gem 'jquery-rails'
gem 'jquery-ui-rails'

group :development do
  gem "rails-erd"
  gem "kumade"
  gem "spin"
  gem "ruby-graphviz"
  
  # Better errors gem set
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  # gem 'ruby-debug19', :require => 'ruby-debug'
  gem "pry"
  gem "rspec-rails", "~> 2.8.0"
  gem 'heroku'
  gem "pickle"
  gem "rails3-generators"
  gem "spork", "~> 0.9.0.rc"
  gem "sunspot_solr", "~> 2.1.0"
  gem 'guard-spin'
end

group :test do
  gem "cucumber-rails", require: false
  gem "factory_girl"
  gem "capybara", git: "https://github.com/jnicklas/capybara.git"
  gem "database_cleaner"
  gem "timecop"
  gem "shoulda", "~> 3.0.0.beta2"
  gem "launchy"
  gem "email_spec", "~> 1.2.1"
  gem "ephemeral_response"
end

group :staging, :production do
  gem "newrelic_rpm"
end
