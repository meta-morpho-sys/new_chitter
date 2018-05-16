# frozen_string_literal: true

require 'bcrypt'

# Interacts with the DB.
class User
  attr_reader :id, :email

  def initialize(id = nil, email = nil, **kwargs)
    @id = id || kwargs[:id]
    @email = email || kwargs[:email]
  end

  def self.create(email, password)
    hashed_pswd = BCrypt::Password.create(password)
    id = DB[:users].insert(email: email, hashed_pswd: hashed_pswd)
    User.new id, email
  end

  def self.find(user_id)
    return nil unless user_id
    u = DB[:users].where(id: user_id).first
    User.new u
  end

  def ==(other)
    @id == other.id && @email == other.email
  end
end

