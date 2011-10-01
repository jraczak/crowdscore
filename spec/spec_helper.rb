require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  # These two lines fix an issue with Spork and Devise preloading the user model
  require "rails/application"
  Spork.trap_method(Rails::Application::RoutesReloader, :reload!)

  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'

  # Fix an issue related to shoulda matchers and Spork
  require 'shoulda/matchers/integrations/rspec'
  require 'carrierwave/test/matchers'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
  end

  # Mock out Fog by pretending a bucket exists
  Fog.mock!
  connection = Fog::Storage.new(:provider => 'AWS')
  connection.directories.create(:key => 'crowdscore-test')
end

Spork.each_run do
  FactoryGirl.definition_file_paths = [ File.join(Rails.root, 'spec', 'factories') ]
  FactoryGirl.find_definitions
end

