# frozen_string_literal: true

# Manages Peep object interactions with the DB.
class Peep
  attr_reader :id, :user_id, :text, :timestamp

  def initialize(id: nil, user_id: nil, text: nil, created_at: nil)
    @id        = id
    @user_id   = user_id
    @text      = text
    @timestamp = created_at.asctime
  end

  def self.create(user_id, text)
    id = DB[:peeps].insert(user_id: user_id, text: text, created_at: Time.now)
    timestamp = DB[:peeps].select(:created_at).first
    Peep.new(id: id, user_id: user_id, text: text, created_at: timestamp[:created_at])
  end

  def self.find(peep_id)
    peep = DB[:peeps].where(id: peep_id).first
    p "in find #{peep}"
    Peep.new(peep)
  end

  def ==(other)
    @id == other.id && @text == other.text && @timestamp == other.timestamp
  end
end
