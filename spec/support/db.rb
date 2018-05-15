# frozen_string_literal: true

Rake.application.load_rakefile

RSpec.configure do |c|
  c.before(:suite) do
    puts 'Cleaning databases.'
    Rake::Task['db:create'].execute
    DB[:users].truncate
  end
end
