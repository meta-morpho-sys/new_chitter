# frozen_string_literal: true

require 'sequel'
require 'pry'
require 'fileutils'
require_relative './app/db/sequel_setup'

task default: :help

desc 'Displays all existing tasks with description'
task :help do
  sh 'rake -T'
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
    show_db_version
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
      raise 'Unable to remove db file' if File.exist?(db_url)
      puts "Sqlite3 database file #{db_url} deleted."
    rescue Errno::ENOENT
      puts 'No such database file.'
    end
  end

  desc 'Perform migration to specified target or 0 as default'
  task :migrate do
    target_arg = ARGV[1].to_i || 0
    Sequel::Migrator.run(DB, 'app/db/migrations', target: target_arg)
    puts 'Migrated to:'
    show_db_version
    exit # This is needed - it prevents args from being run as tasks
  end
end

def show_db_version
  Rake::Task['db:version'].execute
end
