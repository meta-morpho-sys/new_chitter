# frozen_string_literal: true

require_relative '../../../models/user'
require_relative '../../support/db'

describe User do
  describe '.create' do
    it 'adds a new user ' do
      user = User.create 'test@example.com', 'pswd123'
      expect(user.id).not_to be nil
    end

    it "hashes user's password" do
      expect(BCrypt::Password).to receive(:create).with('pswd123').and_return 'hashwithsalt'
      User.create 'test_bcrypt@example.com', 'pswd123'
    end
  end

  describe '.find' do
    it 'a specific user with given ID' do
      user = User.create 'test_find@example.com', 'pswd123'
      expect(User.find(user.id)).to eq user
    end
  end

  describe '#==' do
    example 'two users are equal if their ids and emails match' do
      user1 = User.new 1, 'test_eql1@example.com'
      user2 = User.new 1, 'test_eql1@example.com'
      expect(user1).to eq user2
    end

    example 'two users are not equal if their values are different' do
      user1 = User.new 1, 'test_eql1@example.com'
      user2 = User.new 1, 'test_eql2@example.com'
      expect(user1).not_to eq user2
    end
  end
end
