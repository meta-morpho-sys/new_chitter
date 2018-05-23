# frozen_string_literal: true

require 'timecop'
require_relative '../../../app/models/peep'

describe Peep, :aggregate_failures, :db do
  let(:user) { User.create 'Bob Peep', 'peep_test@example.com', 'pswd123'}
  let(:new_peep) { Peep.create(user.id, 'This is a new peep') }

  context '.create' do
    it 'creates a new peep' do
      expect(new_peep.id).not_to be nil
    end

    it 'returns the time of creation' do
      frozen_time = Timecop.freeze(Time.now)
      expect(new_peep.timestamp).to eq frozen_time
    end
  end
end
