# frozen_string_literal: true

PEEPS_TABLE = :peeps

puts "Creating table >> #{PEEPS_TABLE}" unless DB.table_exists? PEEPS_TABLE

Sequel.migration do
  change do
    create_table PEEPS_TABLE do
      primary_key :id
      foreign_key :user_id, :users, on_delete: :cascade
      String :text, null: false
      DateTime :created_at, null: false
    end
  end
end
