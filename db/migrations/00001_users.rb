# frozen_string_literal: true

table_name = :users

unless DB.table_exists? table_name
puts "Creating table >> #{table_name}"

Sequel.migration do
    change do
      create_table table_name do
        primary_key :id
        String :email, size: 320, null: false, unique: true
        String :hashed_pswd, null: false
      end
    end
  end
end
