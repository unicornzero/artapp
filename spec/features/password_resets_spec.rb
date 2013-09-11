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

  it 'provides success message when validations pass' do
    user = create(:user, password_reset_token: 'something', password_reset_sent_at: 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in 'New Password', with: 'foobar'
    fill_in 'Confirm New Password', with: 'foobar'
    click_button 'Update Password'

    expect(page).to have_content('Password has been reset')
  end

  it 'updates password' do
    user = create(:user, password: 'old_password', password_confirmation: 'old_password', password_reset_token: 'something', password_reset_sent_at: 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in 'New Password', with: 'new_password'
    fill_in 'Confirm New Password', with: 'new_password'
    click_button 'Update Password'
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'new_password'
    click_button 'Log In'

    expect(page).to have_content 'You are logged in.'
    expect(page).to have_content 'Log Out'
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

  it 'blank password fields generate errors' do
    user = create(:user, password_reset_token: 'something', password_reset_sent_at: 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    click_button 'Update Password'

    expect(page).to have_content('Reset Password')
    expect(page).to have_content "Password is too short (minimum is 6 characters)"
  end

  it 'short password with blank confirmation generates errors' do
    user = create(:user, password_reset_token: 'something', password_reset_sent_at: 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in 'New Password', with: 'short'
    click_button 'Update Password'

    expect(page).to have_content 'Reset Password'
    expect(page).to have_content "Password is too short (minimum is 6 characters)"
  end

  it 'short password with blank confirmation generates errors' do
    user = create(:user, password_reset_token: 'something', password_reset_sent_at: 1.hour.ago)
    visit edit_password_reset_path(user.password_reset_token)
    fill_in 'New Password', with: 'short'
    fill_in 'Confirm New Password', with: 'is_longer'
    click_button 'Update Password'

    expect(page).to have_content 'Reset Password'
    expect(page).to have_content "Password is too short (minimum is 6 characters)"
    expect(page).to have_content "Password confirmation doesn't match Password"
  end

  it 'deletes token after password reset'

  it 'requires password length validation'



end