require 'rubygems'
require 'spork'

Spork.prefork do

  ENV["RAILS_ENV"] ||= "test"
  require "rails/application"
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  require 'cucumber/rails'

  Dir["#{Rails.root}/app/models/*.rb"].each { |f| load f }

  Capybara.default_selector = :css

  ActionController::Base.allow_rescue = false

  begin
    DatabaseCleaner.strategy = :transaction
  rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
  end

  require File.expand_path("../cuke_sunspot", __FILE__)
  CukeSunspot.new.start

  at_exit do
    EphemeralResponse.deactivate
    CukeSunspot.new.stop
  end

  EphemeralResponse.configure do |config|
    config.expiration = 1.month
    config.white_list = 'localhost', '127.0.0.1'
    config.debug_output = $stderr
  end

  EphemeralResponse.activate
end

Spork.each_run do
  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end


  # Forces all threads to share the same connection. This works on
  # # Capybara because it starts the web server in a thread.
  ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
  FactoryGirl.definition_file_paths = [ File.join(Rails.root, 'spec', 'factories') ]
  FactoryGirl.find_definitions
end

