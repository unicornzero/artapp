require 'spec_helper'

describe User do
  context 'validations' do
    it 'should pass with valid information' do
      user = build(:user)
      expect(user).to be_valid
    end

    it { should validate_presence_of(:email) }
    it { should allow_value('me@url.com').for(:password) }
    it { should_not allow_value('short').for(:password) }
    it { should_not allow_value('has spaces').for(:email) }
    it { should_not allow_value('incomplete').for(:email) }
    it { should_not allow_value('@.com').for(:email) }
    it { should_not allow_value('@example.com').for(:email) }
    it { should_not allow_value('a' * 100 + '@example.com').for(:email) }
    it { should have_many(:spaces) }
    it { should have_many(:subscriptions) }

    it 'validates uniqueness of email' do
      user1 = create(:user, email: 'myemail@example.com' )
      user2 = build(:user, email: 'myemail@example.com' )
      expect(user2).not_to be_valid
    end

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

  context '#send_password_reset' do
    let(:user) { create(:user) }

    it 'generates a unique password_reset_token each time' do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset

      expect(user.password_reset_token).not_to eq(last_token)
    end

    it 'records time the password reset was sent' do
      user.send_password_reset

      expect(user.reload.password_reset_sent_at).to be_present
    end

    it 'delivers email to user' do
      Resque.inline = true
      user.send_password_reset

      expect(last_email.to).to include(user.email)
    end
  end

  context '#set_super_admin' do
    it 'sets user to super_admin' do
      passphrase = CONFIG[:sapass]
      user = create(:user)
      user.set_super_admin(true, passphrase)

      expect(user).to be_superadmin
    end
  end
end