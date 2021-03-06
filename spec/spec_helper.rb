# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

Bundler.require(:default, ENV['RACK_ENV'].to_sym)

# require our Sinatra app file
require File.join(File.dirname(__FILE__), '..', './app/app.rb')
require_relative 'features/web_helpers'

RSpec.configure do |config|
  config.profile_examples = 5
  config.order = :random
  config.include RspecSequel::Matchers
  # Global require of 'support/db' when tests touch our DB.
  config.when_first_matching_example_defined(:db) do
    require_relative 'support/db'
  end
end

# Setting up driver to communicate with HTML forms with  RESTful routes.
Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(Rack::MethodOverride.new(app))
end

Capybara.app = Chitter

SCF = SimpleCov::Formatter
formatters = [SCF::Console, SCF::HTMLFormatter]
SimpleCov.formatter = SCF::MultiFormatter.new(formatters)

SimpleCov.start
