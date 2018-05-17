# frozen_string_literal: true

require_relative '../../../models/user'

describe User, :aggregate_failures, :db do
  let(:user) { User.create 'Bob', 'test@example.com', 'pswd123' }

  describe '.create' do
    it 'adds a new user ' do
      expect(user.id).not_to be nil
    end

    it "hashes user's password" do
      expect(BCrypt::Password).to receive(:create)
        .with('pswd123').and_return 'hashwithsalt'
      User.create 'Bob', 'test@example.com', 'pswd123'
    end
  end

  describe '.find' do
    example 'a specific user with given ID' do
      expect(User.find(user.id)).to eq user
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
    it 'user provides correct email and password' do
      user
      user_to_authenticate = User.authenticate 'test@example.com', 'pswd123'
      expect(user_to_authenticate.id).to eq user.id
      expect(user_to_authenticate.email).to eq 'test@example.com'
    end
  end

  describe '#==' do
    example 'two users are equal if their ids and emails match' do
      user1 = User.new 1, 'Bob', 'test@example.com'
      user2 = User.new 1, 'Bob', 'test@example.com'
      expect(user1).to eq user2
    end

    example 'two users are not equal if their values are different' do
      user1 = User.new 1, 'Bob', 'test1@example.com'
      user2 = User.new 1, 'Bob', 'test2@example.com'
      expect(user1).not_to eq user2
    end
  end
end
