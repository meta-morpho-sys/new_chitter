# frozen_string_literal: true

# Interacts with the DB.
class User
  attr_reader :id, :email

  def initialize(id, email)
    @id = id
    @email = email
  end

  def self.create(email, password)
    id = DB[:users].insert(email: email, hashed_pswd: password)
    User.new id, email
  end
end

