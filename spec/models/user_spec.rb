require 'spec_helper'

describe 'User' do
  describe 'validations' do
    it 'should pass with valid information' do
      user = User.new(
        email: 'user1@example.com',
        password: 'password1',
        password_confirmation: 'password1'
        )

      expect(user).to be_valid
    end

    context 'password' do
      it 'should be present' do
        user = User.new(
          email: 'user1@example.com',
          password: nil,
          password_confirmation: nil
          )

        expect(user).not_to be_valid
      end

      it 'should not be too short' do
        user = User.new(
          email: 'user1@example.com',
          password: 'cat',
          password_confirmation: 'cat'
          )

        expect(user).not_to be_valid
      end

      its 'should not be too long' do
        user = User.new(
          email: 'user1@example.com',
          password: '123456789_12345679_123456790',
          password_confirmation: '123456789_12345679_123456790'
          )

        expect(user).not_to be_valid
      end
    end
    context 'password confirmation' do
      its 'must match' do
        user = User.new(
          email: 'user1@example.com',
          password: 'password1',
          password_confirmation: 'sssswwww1'
          )
        
        expect(user).not_to be_valid
      end
    end
  end
end