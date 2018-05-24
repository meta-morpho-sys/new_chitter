# frozen_string_literal: true

require 'timecop'
require_relative '../../../app/models/peep'

describe Peep, :aggregate_failures, :db do
  let(:frozen_time){ Timecop.freeze(Time.now) }
  let(:user) { User.create 'Bob Peep', 'peep_test@example.com', 'pswd123'}
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
  end

  describe '#==' do
    example 'a peep is equal to another peep when same ID, text and timestamp' do
      peep1 = Peep.new(id: 1, user_id: 2, text: 'New peep', created_at: frozen_time)
      peep2 = Peep.new(id: 1, user_id: 2, text: 'New peep', created_at: frozen_time)
      expect(peep1).to eq peep2
    end
  end
end
