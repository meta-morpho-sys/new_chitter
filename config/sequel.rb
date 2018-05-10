# frozen_string_literal: true

DB = Sequel.sqlite("./db/#{ENV.fetch('RACK_ENV', 'development')}.db")
