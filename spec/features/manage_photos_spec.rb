require 'spec_helper'

feature 'Manage photos' do
  context 'space-owner' do

    scenario 'can delete a photo' do
      user = create(:user)
      space = create(:space, user_id: user.id)
      visit root_path
      click_link 'Log In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log In'
      visit edit_space_path(space)

      click_link 'Add Image'
      within("#add_image") do
        fill_in 'photo_name', with: 'Masterpiece #3'
        attach_file('photo_image', File.join(Rails.root, 'spec/support/rainbow_ferret.png'))
        click_button 'Upload'
      end
      expect(space.photos.count).to eq(1)

      visit edit_space_path(space)
      click_link 'Delete Image'
      #click_button 'OK' #javascript

      expect(space.photos.count).to eq(0)
      expect(page).to_not have_xpath('//*[@id="Masterpiece #3"]')
      expect(page).to have_content 'Your image has been deleted'
    end

    scenario 'can change photo name' do
      user = create(:user)
      space = create(:space, user_id: user.id)
      visit root_path
      click_link 'Log In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log In'
      visit edit_space_path(space)
      click_link 'Add Image'
      within("#add_image") do
        fill_in 'photo_name', with: 'Masterpiece #3'
        attach_file('photo_image', File.join(Rails.root, 'spec/support/rainbow_ferret.png'))
        click_button 'Upload'
      end
      click_link 'Edit Image'
      fill_in 'photo_name', with: 'My New Name' 
      click_button 'Save'

      expect(page).to have_content 'Your image has been updated'
    end
  end
end