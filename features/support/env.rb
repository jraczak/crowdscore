require 'rubygems'
require 'spork'

Spork.prefork do

  ENV["RAILS_ENV"] ||= "test"
  require "rails/application"
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)
  Dir["#{Rails.root}/app/models/*.rb"].each { |f| load f }

  require 'cucumber/rails'

  Capybara.default_selector = :css

  ActionController::Base.allow_rescue = false

  begin
    DatabaseCleaner.strategy = :transaction
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end
end

Spork.each_run do
  FactoryGirl.definition_file_paths = [ File.join(Rails.root, 'spec', 'factories') ]
  FactoryGirl.find_definitions
end

