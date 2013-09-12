require 'spec_helper'

feature 'User authentication' do
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

  scenario 'log in ' do
    user = create(:user)

    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content 'You are logged in.'
    expect(page).to have_content 'Log Out'
    expect(page).to_not have_content 'Log In'
    expect(page).to_not have_content 'Sign Up'
  end

  scenario 'log out ' do
    user = create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    click_link 'Log Out'

    expect(page).to have_content 'You are logged out.'
    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Sign Up'
    expect(page).to_not have_content 'Log Out'
  end

  it 'errors if invalid email' do
    user = create(:user)

    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: 'wrong@email.com'
    fill_in 'Password', with: user.password
    click_button 'Log In'

    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Invalid login information'
  end

  it 'errors if invalid password' do
    user = create(:user)

    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '1fakepw'
    click_button 'Log In'

    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Invalid login information'
  end

  it 'errors if blank login' do
    user = create(:user)

    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '1fakepw'
    click_button 'Log In'

    expect(page).to have_content 'Log In'
    expect(page).to have_content 'Invalid login information'
  end
end