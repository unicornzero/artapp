require 'spec_helper'

feature 'User account' do 

  scenario 'guest cannot view account' do
    visit '/account'

    expect(page).to have_content 'Not Authorized'
  end

  scenario 'logged-in user can see their info' do
    user = create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    visit '/account'

    expect(page).to have_content 'Your Account'
    expect(page).to have_content user.email
    expect(page).not_to have_content 'Your Spaces'
  end

  scenario 'page owner can see pages' do
    user = create(:user)
    space = create(:space, user_id: user.id)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    visit '/account'

    expect(page).to have_content 'Your Account'
    expect(page).to have_content 'Your Spaces'
    expect(page).to have_content space.name
    expect(page).to have_content 'Edit Page'
    expect(page).to have_content 'View Page'
  end
end