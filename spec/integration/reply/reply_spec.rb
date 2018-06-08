# frozen_string_literal: true

require_relative '../../../app/models/reply'

describe Reply, :aggregate_failures, :db do
  let(:t0) { Time.now }
  let(:t1) { t0 + 10 }
  let(:t2) { t1 + 10 }

  let(:u) { User.create 'Bob', 'bob@example.com', 'pswd123' }
  let(:u2) { User.create 'Alice', 'alice@example.com', 'pswd123' }
  let(:p) { Peep.create(user_id: u.id, text: 'Peep') }
  let(:r) { Reply.create(peep_id: p.id, user_id: u2.id, text: 'Reply 0', created_at: t0) }

  describe '.create' do
    example 'a new reply' do
      expect(r.id).not_to be nil
    end
  end

  describe '.all_reversed' do
    it 'returns all replies sorted with most recent first' do
      r1 = Reply.create(peep_id: p.id, user_id: u2.id, text: 'Reply 1', created_at: t1)
      r2 = Reply.create(peep_id: p.id, user_id: u2.id, text: 'Reply 2', created_at: t2)
      expect(Reply.all_reversed(p.id)).to eq [r2, r1]
    end

    it 'returns all the replies for a specific peep' do
      p1 = Peep.create(user_id: u.id, text: 'Peep1')
      p2 = Peep.create(user_id: u.id, text: 'Peep2')

      r0 = Reply.create(peep_id: p1.id, user_id: u2.id, text: 'Reply to Peep1', created_at: t0)
      r1 = Reply.create(peep_id: p2.id, user_id: u2.id, text: 'Reply to Peep2', created_at: t1)
      r2 = Reply.create(peep_id: p2.id, user_id: u.id, text: 'Reply2 to Peep2', created_at: t2)
      # for p1
      expect(Reply.all_reversed(p1.id)).to include r0
      expect(Reply.all_reversed(p1.id)).not_to include r1
      # for peep2
      expect(Reply.all_reversed(p2.id)).to eq [r2, r1]
      expect(Reply.all_reversed(p2.id)).not_to include r0
    end
  end
end
