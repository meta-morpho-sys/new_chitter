# frozen_string_literal: true

# Written with the aim to study the Sequel::Model class
class Reply < Sequel::Model
  many_to_one :user
  many_to_one :peep

  Reply.create(peep_id: nil, user_id: nil, text: nil, created_at: Time.now)
end
