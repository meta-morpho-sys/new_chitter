# frozen_string_literal: true

require 'timecop'
require_relative '../../../app/models/peep'

describe Peep, :aggregate_failures, :db do
  let(:frozen_time) { Timecop.freeze(Time.now) }
  let(:user) { User.create 'Bob Peep', 'peep_test@example.com', 'pswd123' }
  let(:new_peep) { Peep.create(user.id, 'This is a new peep') }

  context '.create' do
    it 'creates a new peep' do
      expect(new_peep.id).not_to be nil
    end
  end

  context '.find' do
    it 'finds peeps by id' do
      expect(Peep.find(new_peep.id)).to eq new_peep
    end

    it 'returns the time of creation' do
      expect(new_peep.timestamp).to eq frozen_time.asctime
    end

    context 'when the peep lacks an id' do
      it 'returns nil if no ID is given' do
        expect(Peep.find(nil)).to eq nil
      end

      it 'warns when Peep ID is not found' do
        non_existing_id = 2
        expect { Peep.find(non_existing_id) }.to raise_error 'Peep not found'
      end
    end
  end

  describe '.all' do
    it 'returns all peeps if no user ID is provided' do
      user1 = User.create 'Pippo', 'Pippo@example.com', 'pswd123'
      user2 = User.create 'Alice', 'alice@example.com', 'pswd123'
      peep1 = Peep.create(user1.id, 'Pippo is great')
      Timecop.travel(Time.now + 10)
      peep2 = Peep.create(user2.id, 'Alice is great')
      expect(Peep.all).to eq [peep2, peep1]
    end

    it "returns user's peeps sorted with most recent first" do
      peep1 = Peep.create(user.id, 'This is peep 1')
      Timecop.travel(Time.now + 10)
      peep2 = Peep.create(user.id, 'This is peep 2')
      Timecop.travel(Time.now + 10)
      peep3 = Peep.create(user.id, 'This is peep 3')
      expect(Peep.all(user.id)).to eq [peep3, peep2, peep1]
    end

    it 'returns peeps for specific user ID' do
      user1 = User.create 'Pippo', 'Pippo@example.com', 'pswd123'
      user2 = User.create 'Alice', 'alice@example.com', 'pswd123'
      peep1 = Peep.create(user1.id, 'Pippo is great')
      peep2 = Peep.create(user2.id, 'Alice is great')
      expect(Peep.all(user1.id)).to include peep1
      expect(Peep.all(user.id)).not_to include peep2
    end
  end

  describe '#==' do
    example 'two peeps are equal if same ID, text and timestamp' do
      p1 = Peep.new(id: 1, user_id: 2, text: 'A peep', created_at: frozen_time)
      p2 = Peep.new(id: 1, user_id: 2, text: 'A peep', created_at: frozen_time)
      expect(p1).to eq p2
    end
  end
end
