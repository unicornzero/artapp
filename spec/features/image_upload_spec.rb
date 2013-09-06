require 'spec_helper'

feature 'Image Uploads' do
  scenario 'logged-in user can upload an image' do
    pending
    
    user = create(:user)
    space = create(:space)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    visit space_path(space)
    fill_in 'Image Name', with: "First Art Item"
    attach_file('File', File.join(Rails.root, 'spec/support/rainbow_ferret.png'))
    click_button 'Upload'

    expect(page).to have_content 'rainbow_ferret'
  end

  scenario 'guest can not upload image'
  scenario 'multiple images'

end