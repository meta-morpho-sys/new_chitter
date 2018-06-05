# frozen_string_literal: true

require_relative '../../../app/models/reply'

describe Reply, :aggregate_failures, :db do
  let(:frozen_time) { Timecop.freeze(Time.now) }
  let(:frozen_time2) { Timecop.freeze(Time.now + 10) }
  let(:user) { User.create 'Bob', 'bob@example.com', 'pswd123' }
  let(:user2) { User.create 'Alice', 'alice@example.com', 'pswd123' }
  let(:peep) do
    Peep.create(user.id, 'Peep')
  end
  let(:reply) do
    Reply.create(peep_id: peep.id,
                 user_id: user2.id,
                 text: 'Reply 1',
                 created_at: frozen_time)
  end

  describe '.create' do
    example 'a new reply' do
      expect(reply.id).not_to be nil
    end
  end

  describe '.all_reversed' do
    it 'returns all replies sorted with most recent first' do
      reply1 = Reply.create(peep_id: peep.id,
                            user_id: user2.id,
                            text: 'Reply 1',
                            created_at: frozen_time)
      reply2 = Reply.create(peep_id: peep.id,
                            user_id: user2.id,
                            text: 'Reply 2',
                            created_at: frozen_time2)
      expect(Reply.all_reversed).to eq [reply2, reply1]
    end
  end
end
