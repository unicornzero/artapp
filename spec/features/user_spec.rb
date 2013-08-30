require 'spec_helper'

feature 'User management' do
  scenario 'signup' do 
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Confirm Password', with: 'password1'
    click_button 'Create Your Account'
    expect(page).to have_content 'Your account has been created.'
    expect(page).to have_content 'user1@example.com'
  end

  scenario 'log in' do
    visit root_path
    click_link 'Sign Up'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password1'
    fill_in 'Confirm Password', with: 'password1'
    click_button 'Create Your Account'

    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password1'
    click_button 'Log In'
    expect(page).to have_content 'You are logged in.'
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

    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'password1'
    click_button 'Log In'
    click_link 'Log Out'
    expect(page).to have_content 'You are logged out.'
    expect(page).to_not have_content 'Log Out'
    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Sign Up'
  end
end