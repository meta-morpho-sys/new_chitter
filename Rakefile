# frozen_string_literal: true

require 'sequel'
require 'pry'
require 'fileutils'
require './config/sequel'

task default: :help

desc 'Displays all existing tasks with description'
task :help do
  sh 'rake -T'
end

namespace :db do
  desc 'Creates the development database structures.'
  task :create do
    Sequel.extension :migration
    DB = Sequel.sqlite(ENV['DATABASE_URL'])
    puts 'Creating database structures.'
    Sequel::Migrator.run(DB, 'db/migrations')
    puts 'Success!'
  end

  task :teardown do
    db_url = ENV['DATABASE_URL']
    begin
      FileUtils.remove(db_url)
      puts "Sqlite3 database file #{db_url} deleted."
    rescue Errno::ENOENT
      puts 'No such database'
    end
  end
end

