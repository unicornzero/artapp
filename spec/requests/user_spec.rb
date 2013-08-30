require 'spec_helper'

describe 'User' do
  it 'can create account' do
    user = create(:user)

    expect(user).to be_valid
  end
end