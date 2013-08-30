require 'spec_helper'

feature 'User management' do
  scenario 'create a new user' do
    'implementation of User'
    
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Confirm Password', with: 'password1'
    click_button 'Create Your Account'
    expect(page).to have_content 'Your account has been created.'
  end
end