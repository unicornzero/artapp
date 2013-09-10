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

  it 'updates user password when confirmation matches' do
    user = create(:user, password_reset_token: 'something', password_reset_sent_at: 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in 'New Password', with: 'foobar'
    fill_in 'Confirm New Password', with: 'foobar'
    click_button 'Update Password'

    expect(page).to have_content('Password has been reset')
  end

  it 'reports when password token has expired' do
    user = create(:user, password_reset_token: 'something', password_reset_sent_at: 5.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in 'New Password', with: 'foobar'
    fill_in 'Confirm New Password', with: 'foobar'
    click_button 'Update Password'

    expect(page).to have_content('Password reset has expired')
  end

  it 'raises record not found when password token is invalid' do
    my_action = lambda { visit edit_password_reset_path('invalid') }

    expect(my_action).to raise_exception(ActiveRecord::RecordNotFound)
  end
end