# frozen_string_literal: true

require 'sequel'

ENV['DATABASE_URL'] ||= "./db/#{ENV.fetch('RACK_ENV', 'development')}.db"
DB = Sequel.sqlite(ENV['DATABASE_URL'])
