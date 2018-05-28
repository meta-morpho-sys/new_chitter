# frozen_string_literal: true

require_relative '../../../app/models/user'

describe User, :aggregate_failures, :db do
  let(:created_user) { User.create 'Bob', 'test@example.com', 'pswd123' }

  describe '.create' do
    it 'adds a new user ' do
      expect(created_user.id).not_to be nil
    end

    it "hashes user's password" do
      expect(BCrypt::Password).to receive(:create)
        .with('pswd123').and_return 'hashwithsalt'
      User.create 'Bob', 'test@example.com', 'pswd123'
    end
  end

  describe '.find' do
    example 'a specific user with given ID' do
      expect(User.find(created_user.id)).to eq created_user
    end

    context 'when the user lacks an id' do
      it 'returns nil if no ID is given' do
        expect(User.find(nil)).to eq nil
      end

      it 'warns when user ID is not found' do
        non_existing_id = 2
        expect { User.find(non_existing_id) }.to raise_error 'User not found'
      end
    end
  end

  describe '.authenticate' do
    example 'user provides correct email and password' do
      created_user
      user_to_authenticate = User.authenticate 'test@example.com', 'pswd123'
      expect(user_to_authenticate.id).to eq created_user.id
      expect(user_to_authenticate.email).to eq 'test@example.com'
    end

    example 'user provides incorrect email' do
      expect(User.authenticate('wrong_email@example.com', 'pswd123')).to be_nil
    end

    example 'user provides incorrect password' do
      expect(User.authenticate('test@example.com', 'wrong_pswd')).to be_nil
    end
  end

  describe '#==' do
    example 'two users are equal if their ids and emails match' do
      user1 = User.new id: 1, name: 'Bob', email: 'test@example.com'
      user2 = User.new id: 1, name: 'Bob', email: 'test@example.com'
      expect(user1).to eq user2
    end

    example 'two users are not equal if their values are different' do
      user1 = User.new id: 1, name: 'Bob', email: 'test1@example.com'
      user2 = User.new id: 1, name: 'Bob', email: 'test2@example.com'
      expect(user1).not_to eq user2
    end
  end

  describe '.exists?' do
    it 'returns false if the user has never been created' do
      expect(User.exists?('non_existing@example.com')).to eq false
    end
  end

  describe '#peeps' do
    it 'fetches peeps created by a specific user' do
      peep1 = Peep.create created_user.id, 'Test for peeps'
      peep2 = Peep.create created_user.id, 'Test2 for peeps'
      expect(created_user.peeps).to eq [peep2, peep1]
    end
  end
end
