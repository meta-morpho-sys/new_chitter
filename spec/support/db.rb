# frozen_string_literal: true

RSpec.configure do |c|
  c.before(:suite) do
    Sequel.extension :migrations
    Sequel::Migrator.run(DB, 'db/migrations')
    DB[:users].truncate
  end
end
