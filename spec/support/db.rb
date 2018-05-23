# frozen_string_literal: true

Rake.application.load_rakefile

RSpec.configure do |c|
  # Makes sure the structure is set up and empty
  # before running the suite of tests.
  c.before(:suite) do
    puts 'Cleaning databases.'
    Rake::Task['db:create'].execute
    DB[:users].truncate
    DB[:peeps].truncate
  end
  # The following will roll back the transactions
  # after each example has been run.
  c.around(:example, :db) do |example|
    puts 'Rolling back transaction'
    DB.transaction(rollback: :always) { example.run }
  end
end
