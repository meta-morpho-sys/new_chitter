# frozen_string_literal: true

Rake.application.load_rakefile

RSpec.configure do |c|
  c.before(:suite) do
    puts 'Cleaning databases.'
    Rake::Task['db:create'].execute
    DB[:users].truncate
  end
  c.around(:example, :db) do |example|
    puts 'Rolling back transaction'
    DB.transaction(rollback: :always) { example.run }
  end
end
