# frozen_string_literal: true

require_relative '../../../app/models/reply'

describe Reply, :aggregate_failures, :db do
  let(:frozen_time) { Timecop.freeze(Time.now) }
  let(:frozen_time2) { Timecop.freeze(Time.now + 10) }
  let(:user) { User.create 'Bob', 'test@example.com', 'pswd123' }
  let(:peep) do
    Peep.create(user.id, 'Rumours that GItHub will be acquired by Microsoft!')
  end
  let(:reply) do
    Reply.create(peep_id: peep.id,
                 user_id: user.id,
                 text: 'Microsoft confirms',
                 created_at: frozen_time)
  end

  describe '.create' do
    example 'a new reply' do
      expect(reply.id).not_to be nil
    end
  end
end
