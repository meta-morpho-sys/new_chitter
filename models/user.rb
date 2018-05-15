# frozen_string_literal: true

require 'bcrypt'

# Interacts with the DB.
class User
  attr_reader :id, :email

  def initialize(id, email)
    @id = id
    @email = email
  end

  def self.create(email, password)
    hashed_pswd = BCrypt::Password.create(password)
    id = DB[:users].insert(email: email, hashed_pswd: hashed_pswd)
    User.new id, email
  end
end

