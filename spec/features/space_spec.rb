require 'spec_helper'

feature 'Space' do
  scenario 'guest can view', focus: true do
    space = create(:space)
    
    visit space_path(space)

    expect(page).to have_content space.name
  end

  scenario 'logged-in user can edit' do
    user = create(:user)
    space = create(:space)

    visit edit_space_path(space)
    click_button 'Save'

    expect(page).to have_content 'Your changes have been saved'
  end

  scenario 'logged-out user cannot cannot edit' do
    space = create(:space)

    visit edit_space_path(space)

    expect(page).to have_content 'Unauthorized'
  end

end