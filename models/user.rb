# frozen_string_literal: true

require 'bcrypt'

# Interacts with the DB.
class User
  include BCrypt
  attr_reader :id, :name, :email

  def initialize(id: nil, name: nil, email: nil, **kwargs)
    @id = id || kwargs[:id]
    @name = name || kwargs[:name]
    @email = email || kwargs[:email]
  end

  def self.create(name, email, password)
    hashed_pswd = BCrypt::Password.create(password)
    id = DB[:users].insert(name: name, email: email, hashed_pswd: hashed_pswd)
    User.new id: id, name: name, email: email
  end

  def self.find(user_id)
    return nil unless user_id
    u = DB[:users].where(id: user_id).first
    raise 'User not found' if u.nil?
    User.new u
  end

  def self.authenticate(email, password)
    result = DB[:users].where(email: email).first
    return if result.nil?
    return unless BCrypt::Password.new(result[:hashed_pswd]) == password
    User.new(**result)
  end

  def ==(other)
    @id == other.id && @email == other.email
  end
end

