# frozen_string_literal: true

table_name = :users

puts "Creating table >> #{table_name}" unless DB.table_exists? table_name

Sequel.migration do
  change do
    create_table table_name do
      primary_key :id
      String :name, size: 320, null: false
      String :email, size: 320, null: false, unique: true
      String :hashed_pswd, null: false
    end
  end
end
