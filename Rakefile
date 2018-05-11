# frozen_string_literal: true

require 'sequel'
require './config/sequel'

task default: :help

desc 'Displays all existing tasks with description'
task :help do
  sh 'rake -T'
end

namespace :db do
  desc 'Creates the development database structures.'
  task :create do
    puts 'Creating database structures.'
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
  end
end

