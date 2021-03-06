source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.2'
gem 'rake', '~> 10.4.2'

gem "pg"
gem "inherited_resources"
gem "slim-rails"
#gem "devise", "~> 2.1.0"
gem "devise" #, "~> 3.0.0"
gem "cancan"
gem 'unicorn'
gem "thin"
gem "carrierwave"
gem "rmagick", "~> 2.13.2"
gem "fog", "~> 1.3.1"

gem "will_paginate", "~> 3.0.0"
gem "state_select", git: "git://github.com/jraczak/state_select.git"
#git: "git@github.com:heimidal/state_select.git"
#gem "acts_as_audited", "2.0.0"
gem 'audited-activerecord'

gem "airbrake"
#gem "sunspot_rails"
gem "geocoder"
gem "rails-backbone", "~> 0.7.0"
gem "ejs"
gem "omniauth-facebook", '~> 1.4.0'
gem "gmaps4rails", "~> 1.5.6"
gem "merit"
#gem "sunspot_solr", "~> 2.1.0"
gem "devise_invitable", "~> 1.1.0"
gem 'aws-sdk'
gem 'factual-api'
gem 'geokit', branch: 'master', git: 'https://github.com/geokit/geokit.git'
gem 'geokit-rails'
gem 'timezone'
gem 'nearest_time_zone'
gem 'simple_form'
gem 'fb_graph'
gem 'delayed_job_active_record'
gem 'daemons'
gem 'rails_12factor'
gem 'mixpanel-ruby'
gem 'pry'

gem 'carrierwave_direct'

gem 'hirefire-resource'

gem 'elasticsearch-model'
gem 'elasticsearch-rails'

# Gems for monitoring
gem 'skylight'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'bourbon'
  gem 'uglifier', ">= 1.0.3"
  gem "font-awesome-rails"
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
  gem "rspec-rails", "~> 2.12.0"
  gem 'heroku'
  gem "pickle"
  gem "rails3-generators"
  gem "spork", "~> 0.9.0.rc"
  #gem "sunspot_solr", "~> 2.1.0"
  gem 'guard-spin'
end

group :test do
  gem "cucumber-rails", require: false
  gem "factory_girl"
  gem "database_cleaner"
  gem "timecop"
  gem "shoulda", "~> 3.0.0.beta2"
  gem "launchy"
  #gem "email_spec", "~> 1.5.0"
  gem "ephemeral_response"
end

#add gems for sauce labs testing
group :test, :development do
  gem "capybara", git: "https://github.com/jnicklas/capybara.git"
  gem 'sauce', '~> 3.1.1'
  gem 'sauce-connect'
  gem 'parallel_tests'
end
  

group :staging, :production do
  gem "newrelic_rpm"
end
