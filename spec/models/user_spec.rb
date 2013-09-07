require 'spec_helper'

describe User do
  describe 'validations' do
    it 'should pass with valid information' do
      user = build(:user)
      expect(user).to be_valid
    end

    it { should validate_presence_of(:email) }
    xit { should validate_uniqueness_of(:email) } #pending https://github.com/thoughtbot/shoulda-matchers/commit/6336dd4987d0b6948e56dcf4259cfcb0c53f2666
    it { should_not allow_value("short").for(:password) }
    it { should_not allow_value("has spaces").for(:email) }
    it { should_not allow_value("incomplete").for(:email) }
    it { should_not allow_value("@.com").for(:email) }
    it { should_not allow_value("@example.com").for(:email) }
    it { should_not allow_value("a" * 100 + "@example.com").for(:email) }

    context 'password' do
      it 'should be present' do
        user = build(:user, password: nil, password_confirmation: nil)
        expect(user).not_to be_valid
      end

      it 'should not be too short' do
        user = build(:user, password: 'cat', password_confirmation: 'cat')
        expect(user).not_to be_valid
      end

      its 'should not be too long' do
        user = build(:user, password: '123456789_12345679_123456790', password_confirmation: '123456789_12345679_123456790')
        expect(user).not_to be_valid
      end
    end

    context 'password confirmation' do
      its 'must match' do
        user = build(:user, password: 'password1', password_confirmation: 'sssswwww1')
        expect(user).not_to be_valid
      end
    end
  end


end