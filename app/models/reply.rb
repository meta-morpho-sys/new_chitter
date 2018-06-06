# frozen_string_literal: true

# Written with the aim to study the Sequel::Model class
class Reply < Sequel::Model
  many_to_one :user
  many_to_one :peep

  def self.all_reversed
    Reply.reverse(:created_at).all
  end
end
