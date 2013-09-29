require 'spec_helper'

feature 'Import Spaces' do
  scenario 'superadmin can import spaces' do
    user = create(:user, superadmin: true)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    visit spaces_path
    click_link 'Import'
    attach_file('File', File.join(Rails.root, 'spec/support/import_spaces.csv'))
    click_button 'Import'

    expect(page).to have_content 'Import Complete'
  end

  scenario 'guest can not import spaces', focus: true do
    visit new_space_import_path

    expect(page).to have_content 'Not Authorized'
  end

end