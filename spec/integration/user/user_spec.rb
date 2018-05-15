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
      User.create 'test@example.com', 'pswd123'
    end
  end
end
