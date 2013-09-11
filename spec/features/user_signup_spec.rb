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

  scenario 'blank form generates errors' do
    visit root_path

    click_link 'Sign Up'
    click_button 'Create Your Account'

    expect(page).to have_content 'Sign Up'
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Email is invalid"
    expect(page).to have_content "Password can't be blank"
  end

  scenario 'invalid password w/o confirmation generates errors' do
    visit root_path

    click_link 'Sign Up'
    click_button 'Create Your Account'
    fill_in 'Email', with: 'user1@example.com'
    fill_in 'Password', with: 'short'
    click_button 'Create Your Account'

    expect(page).to have_content 'Sign Up'
    expect(page).to have_content "Password confirmation can't be blank"
    expect(page).to have_content "Password is too short (minimum is 6 characters)"
    expect(page).to have_content "Password confirmation doesn't match Password"

  end

  scenario 'valid password w/o confirmation generates errors' do
    visit root_path

    click_link 'Sign Up'
    click_button 'Create Your Account'
    fill_in 'Email', with: 'new_user@example.com'
    fill_in 'Password', with: 'myvalidpassword'
    click_button 'Create Your Account'

    expect(page).to have_content 'Sign Up'
    expect(page).to have_content "Password confirmation can't be blank"
    expect(page).to have_content "Password confirmation doesn't match Password"

  end

end