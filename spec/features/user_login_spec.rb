require 'spec_helper'

feature 'User management' do
  scenario 'signup logs user in' do
    visit root_path

    click_link 'Sign Up'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Confirm Password', with: 'password1'
    click_button 'Create Your Account'

    expect(page).to have_content 'Log Out'
    expect(page).to_not have_content 'Log In'
    expect(page).to_not have_content 'Sign Up'
  end

  scenario 'log out ' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Confirm Password', with: 'password1'
    click_button 'Create Your Account'

    click_link 'Log Out'

    expect(page).to have_content 'You are logged out.'
    expect(page).to_not have_content 'Log Out'
    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Sign Up'
  end

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