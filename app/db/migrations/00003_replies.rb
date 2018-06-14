# frozen_string_literal: true

REPLIES_TABLE = :replies

puts "Creating table >> #{REPLIES_TABLE}" unless DB.table_exists? REPLIES_TABLE

Sequel.migration do
  change do
    create_table REPLIES_TABLE do
      primary_key :id
      foreign_key :peep_id, :peeps, on_delete: :cascade
      foreign_key :user_id, :users, on_delete: :cascade
      String :text, null: false
      DateTime :created_at, null: false
    end
  end
end

