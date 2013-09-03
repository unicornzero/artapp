require 'spec_helper'

feature 'Space' do
  scenario 'guest can view' do
    space = create(:space)
    
    visit space_path(space)

    expect(page).to have_content space.name
  end

  scenario 'logged-in user can create' do
    user = create(:user)
    space = attributes_for(:space)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    visit new_space_path(space)
    expect(page).to have_content 'Create a New Space'
    fill_in 'Name', with: space[:name]
    click_button 'Save'

    expect(page).to have_content 'Your Space has been created'
    expect(page).to have_content space[:name]
  end

  scenario 'logged-in user can edit' do
    user = create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    space = create(:space)

    visit edit_space_path(space)
    expect(page).to have_content space.name
    fill_in 'Name', with: 'Modified Name'
    click_button 'Save'

    expect(page).to have_content 'Your changes have been saved'
    expect(page).to have_content 'Modified Name'
  end

  scenario 'logged-out user cannot cannot edit' do
    space = create(:space)

    visit edit_space_path(space)

    expect(page).to have_content 'Not Authorized'
  end

end