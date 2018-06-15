# frozen_string_literal: true

require 'timecop'
require_relative '../../../app/models/peep'

describe Peep, :aggregate_failures, :db do
  let(:t0) { Time.now }
  let(:t1) { t0 + 10 }
  let(:t2) { t1 + 10 }
  let(:frz_time) { Timecop.freeze(Time.now) }
  let(:u) { User.create 'Bob Peep', 'peep_test@example.com', 'pswd123' }
  let(:p) { Peep.create(user_id: u.id, text: 'New peep', created_at: frz_time) }

  it { is_expected.to validate_presence :text }
  it { is_expected.to validate_presence :created_at, message: 'is nil. Check your create/update method calls.' }


  context '.create' do
    it 'creates a new peep' do
      expect(p.id).not_to be nil
    end
  end

  context '.find' do
    it 'finds peeps by id' do
      expect(Peep.find(p.id)).to eq p
    end

    it 'returns the time of creation' do
      # TODO: think about where to format the time ".strftime(StrMsgs::TIME_FORMAT)"
      expect(p.created_at.strftime(StrMsgs::TIME_FORMAT))
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
      u1 = User.create 'Pippo', 'Pippo@example.com', 'pswd123'
      u2 = User.create 'Alice', 'alice@example.com', 'pswd123'
      p1 = Peep.create(user_id: u1.id, text: 'Pippo is great', created_at: t1)
      p2 = Peep.create(user_id: u2.id, text: 'Alice is great', created_at: t1)
      expect(Peep.all_per(u1.id)).to include p1
      expect(Peep.all_per(u1.id)).not_to include p2
    end

    it "returns user's peeps sorted with most recent first" do
      p1 = Peep.create(user_id: u.id, text: 'Peep 1', created_at: t1)
      p2 = Peep.create(user_id: u.id, text: 'Peep 2', created_at: t2)
      expect(Peep.all_per(u.id)).to eq [p2, p1]
    end
  end

  describe '.all' do
    it 'returns all peeps if no user ID is provided' do
      u1 = User.create 'Pippo', 'Pippo@example.com', 'pswd123'
      u2 = User.create 'Alice', 'alice@example.com', 'pswd123'
      p1 = Peep.create(user_id: u1.id, text: 'Pippo is great', created_at: t1)
      p2 = Peep.create(user_id: u2.id, text: 'Alice is great', created_at: t2)
      expect(Peep.all).to eq [p2, p1]
    end
  end
end
