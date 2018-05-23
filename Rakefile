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

def retrieve_target_arg
  ARGV.size == 1 ? 0 : ARGV[1].to_i
end

namespace :db do
  Sequel.extension :migration

  desc 'Print current schema version'
  task :version do
    version = if DB.tables.include?(:schema_info)
                DB[:schema_info].first[:version]
              end || 0
    puts "Schema version #{version}."
  end

  desc 'Creates the development database structures.'
  task :create do
    puts 'Creating database structures.'
    puts 'Migrating to the latest migration available.'
    Sequel::Migrator.run(DB, 'app/db/migrations')
    puts 'Success!'
    Rake::Task['db:version'].execute
  end

  desc 'Deletes the DB files'
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

  desc 'Perform rollback to specified target or full rollback as default'
  task :rollback do
    ARGV.each { |a| task a.to_sym do; end }
    Sequel::Migrator.run(DB, 'app/db/migrations', target: retrieve_target_arg)
    Rake::Task['db:version'].execute
  end
end


