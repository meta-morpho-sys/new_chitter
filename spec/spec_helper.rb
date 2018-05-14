# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

Bundler.require(:default, ENV['RACK_ENV'].to_sym)

# require our Sinatra app file
require File.join(File.dirname(__FILE__), '..', 'app.rb')

RSpec.configure do |config|
  config.order = :random
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
