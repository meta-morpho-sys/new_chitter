# frozen_string_literal: true

# Written with the aim to study the Sequel::Model class
class Reply < Sequel::Model
  plugin :validation_helpers
  many_to_one :user
  many_to_one :peep

  def validate
    super
    validates_presence :text
  end

  def self.all_reversed(peep_id)
    Reply.where(peep_id: peep_id).reverse(:created_at).all
  end
end
