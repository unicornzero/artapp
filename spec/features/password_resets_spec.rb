require 'spec_helper'

describe "PasswordResets" do
  
  it 'emails user requesting password reset' do
    user = create(:user)
    visit login_path
    click_link 'Forgot password?'
    fill_in 'Email', with: user.email
    click_button 'Reset Password'

    current_path.should eq(root_path)
    expect(page).to have_content('email sent')
    expect(last_email.to).to include(user.email)
  end

  it 'does not email invalid user' do
    visit login_path
    click_link 'Forgot password?'
    fill_in 'Email', with: 'fake@example.com'
    click_button 'Reset Password'

    current_path.should eq(root_path)
    expect(page).to have_content('email sent')
    expect(last_email).to be_nil
  end

end