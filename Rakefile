# frozen_string_literal: true

require 'sequel'
require 'pry'
require 'fileutils'
require './app/app'

task default: :help

desc 'Displays all existing tasks with description'
task :help do
  sh 'rake -T'
end

namespace :db do
  desc 'Creates the development database structures.'
  task :create do
    Sequel.extension :migration
    puts 'Creating database structures.'
    Sequel::Migrator.run(DB, 'app/db/migrations')
    puts 'Success!'
  end

  task :teardown do
    puts "*** Deleting database files ***.\n\n"
    puts "    Press 'y' to confirm you want to delete the Chitter database.\n\n"
    puts '*** Attention! All data will be lost! ***'
    print '>>'

    confirm = STDIN.gets.chomp.downcase
    return unless confirm == 'y'

    db_url = ENV['DATABASE_URL']
    begin
      FileUtils.remove(db_url)
      puts "Sqlite3 database file #{db_url} deleted."
    rescue Errno::ENOENT
      puts 'No such database file.'
    end
  end
end

