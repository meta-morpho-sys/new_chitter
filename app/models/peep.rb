# frozen_string_literal: true

# Manages Peep object interactions with the DB.
class Peep
  PEEPS_DS = DB[:peeps]

  attr_reader :id, :user_id, :text, :timestamp

  def initialize(id: nil, user_id: nil, text: nil, created_at: nil, **kwargs)
    @id        = id || kwargs[:id]
    @user_id   = user_id || kwargs[:user_id]
    @text      = text || kwargs[:text]
    @timestamp = created_at.asctime || kwargs[:created_at].asctime
  end

  def self.create(user_id, text)
    now = Time.now
    id = PEEPS_DS.insert(user_id: user_id, text: text, created_at: now)
    Peep.new(id: id, user_id: user_id, text: text, created_at: now)
  end

  def self.find(peep_id)
    return nil unless peep_id
    peep = PEEPS_DS.where(id: peep_id).first
    raise 'Peep not found' if peep.nil?
    Peep.new(**peep)
  end

  def self.all(user_id = nil)
    result = if user_id.nil?
               PEEPS_DS.order(Sequel.desc(:created_at)).all
             else
               PEEPS_DS
                 .where(user_id: user_id)
                 .order(Sequel.desc(:created_at)).all
             end
    result.map { |r| Peep.new r }
  end

  def ==(other)
    @id == other.id && @text == other.text && @timestamp == other.timestamp
  end
end
