# frozen_string_literal: true

USERS_TABLE = :users

puts "Creating table >> #{USERS_TABLE}" unless DB.table_exists? USERS_TABLE

Sequel.migration do
  change do
    create_table USERS_TABLE do
      primary_key :id
      String :name, size: 320, null: false
      String :email, size: 320, null: false, unique: true
      String :hashed_pswd, null: false
    end
  end
end
