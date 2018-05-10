# frozen_string_literal: true

Sequel.migration do
  change do
    create_table :users do
      primary_key :id
      String :usr_name
      String :email, size: 320, null: false, unique: true
      String :hashed_pswd, null: false
    end
  end
end
