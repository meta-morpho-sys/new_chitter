# frozen_string_literal: true

table_name = :peeps

puts "Creating table >> #{table_name}" unless DB.table_exists? table_name

Sequel.migration do
  change do
    create_table table_name do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade
      String :text, null: false
      DateTime :created_at, null: false
    end
  end
end
