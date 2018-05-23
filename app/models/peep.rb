# frozen_string_literal: true

# Manages Peep object interactions with the DB.
class Peep
  attr_reader :id, :user_id, :text, :timestamp

  def initialize(id, user_id, text, timestamp)
    @id        = id
    @user_id   = user_id
    @text      = text
    @timestamp = timestamp
  end

  def self.create(user_id, text)
    id = DB[:peeps].insert(user_id: user_id, text: text, created_at: Time.now)
    timestamp = DB[:peeps].select(:created_at).first
    Peep.new(id, user_id, text, timestamp[:created_at])
  end
end
