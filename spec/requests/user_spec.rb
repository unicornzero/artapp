require 'spec_helper'

describe 'User' do
  it 'can create account' do
    user = User.new(
      email: 'user1@example.com',
      password: 'password1',
      password_confirmation: 'password1'
      )
    expect(user).to be_valid
  end
end