# frozen_string_literal: true

require 'timecop'
require_relative '../../../app/models/peep'

describe Peep, :aggregate_failures, :db do
  let(:frz_time) { Timecop.freeze(Time.now) }
  let(:user) { User.create 'Bob Peep', 'peep_test@example.com', 'pswd123' }
  let(:peep) { Peep.create(user_id: user.id, text: 'My new peep', created_at: frz_time) }

  context '.create' do
    it 'creates a new peep' do
      expect(peep.id).not_to be nil
    end
  end

  context '.find' do
    it 'finds peeps by id' do
      expect(Peep.find(peep.id)).to eq peep
    end

    it 'returns the time of creation' do
      # TODO: think about where to format the time ".strftime(StrMsgs::TIME_FORMAT)"
      expect(peep.created_at.strftime(StrMsgs::TIME_FORMAT))
        .to eq frz_time.strftime(StrMsgs::TIME_FORMAT)
    end

    context 'when the peep lacks an id' do
      it 'warns when Peep ID is not found' do
        non_existing_id = 2
        expect { Peep.with_pk!(non_existing_id) }
          .to raise_error Sequel::NoMatchingRow
      end
    end
  end

  describe '.all_per' do
    it 'returns peeps for specific user ID' do
      user1 = User.create 'Pippo', 'Pippo@example.com', 'pswd123'
      user2 = User.create 'Alice', 'alice@example.com', 'pswd123'
      peep1 = Peep.create(user_id: user1.id, text: 'Pippo is great')
      peep2 = Peep.create(user_id: user2.id, text: 'Alice is great')
      expect(Peep.all_per(user1.id)).to include peep1
      expect(Peep.all_per(user1.id)).not_to include peep2
    end

    it "returns user's peeps sorted with most recent first" do
      t1 = Time.now
      t2 = t1 + 10
      peep1 = Peep.create(user_id: user.id, text: 'Peep 1', created_at: t1)
      peep2 = Peep.create(user_id: user.id, text: 'Peep 2', created_at: t2)
      expect(Peep.all_per(user.id)).to eq [peep2, peep1]
    end
  end

  describe '.all' do
    it 'returns all peeps if no user ID is provided' do
      t1 = Time.now
      t2 = t1 + 10
      user1 = User.create 'Pippo', 'Pippo@example.com', 'pswd123'
      user2 = User.create 'Alice', 'alice@example.com', 'pswd123'
      peep1 = Peep.create(user_id: user1.id, text: 'Pippo is great', created_at: t1)
      peep2 = Peep.create(user_id: user2.id, text: 'Alice is great', created_at: t2)
      expect(Peep.all).to eq [peep2, peep1]
    end
  end
end
