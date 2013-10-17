require 'spec_helper'

feature 'edit Pro Space fields' do 

  scenario 'page owner can edit description field', js: true, focus: true do
    user = create(:user)
    space = create(:space, user_id: user.id, plan: 'Pro')
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    visit '/account'
    click_link 'Edit Space'

    fill_in 'Description', with: 'This gallery is fabulously wonderful, with an extensive collection of really great art.'
    click_button 'Save'

    expect(page).to have_content 'fabulously wonderful'
    expect(page).to have_content 'Your changes have been saved.'
  end
end