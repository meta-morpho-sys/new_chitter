# frozen_string_literal: true

require 'sequel'

ENV['DATABASE_URL'] ||= "./app/db/#{ENV.fetch('RACK_ENV', 'development')}.db"
puts "Using database #{ENV['DATABASE_URL']}"
DB = Sequel.sqlite(ENV['DATABASE_URL'])
