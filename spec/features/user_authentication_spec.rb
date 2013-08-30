require 'spec_helper'

feature 'User authorization' do
  scenario 'guest cannot visit admin page' do
    visit adminz_path

    expect(page).to have_content 'Not Authorized.'
    expect(current_path).to eq root_path
  end

  scenario 'logged-in user can view admin page' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Confirm Password', with: 'password1'
    click_button 'Create Your Account'

    visit adminz_path
    
    expect(page).to have_content 'This is the admin page.'
    expect(current_path).to_not eq root_path
  end
end