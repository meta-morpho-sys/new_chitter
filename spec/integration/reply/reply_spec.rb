# frozen_string_literal: true

require_relative '../../../app/models/reply'

describe Reply, :aggregate_failures, :db do
  let(:time0) { Time.now }
  let(:time1) { time0 + 10 }
  let(:time2) { time1 + 10 }

  let(:user) { User.create 'Bob', 'bob@example.com', 'pswd123' }
  let(:user2) { User.create 'Alice', 'alice@example.com', 'pswd123' }
  let(:peep) do
    Peep.create(user.id, 'Peep')
  end
  let(:reply) do
    Reply.create(peep_id: peep.id,
                 user_id: user2.id,
                 text: 'Reply 0',
                 created_at: time0)
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
                            created_at: time1)
      reply2 = Reply.create(peep_id: peep.id,
                            user_id: user2.id,
                            text: 'Reply 2',
                            created_at: time2)
      expected = [reply2, reply1, reply]
      actual = Reply.all_reversed
      expect(actual).to eq expected
      pp expected.map(&:text)
      pp actual.map(&:text)
    end
  end
end
