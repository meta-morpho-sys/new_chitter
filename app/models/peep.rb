# frozen_string_literal: true

# Manages Peep object interactions with the DB.
class Peep
  PEEPS_DS = DB[:peeps]

  attr_reader :id, :user_id, :text, :timestamp

  def initialize(id: nil, user_id: nil, text: nil, created_at: nil)
    @id        = id
    @user_id   = user_id
    @text      = text
    @timestamp = created_at.asctime
  end

  def self.create(user_id, text)
    id = PEEPS_DS.insert(user_id: user_id, text: text, created_at: Time.now)
    res = PEEPS_DS.select(:created_at).first
    Peep.new(id: id, user_id: user_id, text: text, created_at: res[:created_at])
  end

  def self.find(peep_id)
    peep = PEEPS_DS.where(id: peep_id).first
    Peep.new(peep)
  end

  def ==(other)
    @id == other.id && @text == other.text && @timestamp == other.timestamp
  end
end
