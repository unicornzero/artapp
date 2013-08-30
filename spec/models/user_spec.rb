require 'spec_helper'

describe 'User' do
  describe 'validations' do
    it 'should be valid with valid information' do
      user = User.new(
        email: 'user1@example.com',
        password: 'password1',
        password_confirmation: 'password1'
        )
      expect(user).to be_valid
    end

    its 'should not be valid with a confirmation mismatch' do
      user = User.new(
        email: 'user1@example.com',
        password: 'password1',
        password_confirmation: 'sssswwww1'
        )
      expect(user).to_not be_valid
    end

    it 'should not be valid without a password' do
      user = User.new(
        email: 'user1@example.com',
        password: nil,
        password_confirmation: nil
        )
      expect(user).to_not be_valid
    end

    it 'should not be valid with a short password' do
      user = User.new(
        email: 'user1@example.com',
        password: 'cat',
        password_confirmation: 'cat'
        )
      expect(user).to_not be_valid
    end

    its 'should not be valid with a long password' do
      user = User.new(
        email: 'user1@example.com',
        password: '123456789_12345679_123456790',
        password_confirmation: '123456789_12345679_123456790'
        )
      expect(user).to_not be_valid
    end
  end
end