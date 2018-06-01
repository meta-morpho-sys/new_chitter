# frozen_string_literal: true

table_name = :replies

puts "Creating table >> #{table_name}" unless DB.table_exists? table_name

Sequel.migration do
  change do
    create_table table_name do
      primary_key :id
      foreign_key :peep_id, :peeps, on_delete: :cascade
      foreign_key :user_id, :users, on_delete: :cascade
      String :text
      DateTime :created_at
    end
  end
end
