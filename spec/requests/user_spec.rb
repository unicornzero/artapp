require 'spec_helper'

describe 'User' do
  it 'can create account' do
    user = User.new
    expect(user).to be_valid
  end

  it 'can login'
end