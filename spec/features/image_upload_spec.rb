require 'spec_helper'

feature 'Image Uploads' do
  scenario 'logged-in user can upload an image' do  
    user = create(:user)
    space = create(:space)
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

    expect(page).to have_xpath('//*[@id="Masterpiece #3"]')
    expect(page).to have_content 'Masterpiece #3'
    expect(page).to have_content 'Your image has been uploaded'
  end

  scenario 'guest can not upload image' do
    space = create(:space)

    visit edit_space_path(space)

    expect(page).to have_content 'Not Authorized'
  end

  scenario 'display errors if invalid upload' do
    user = create(:user)
    space = create(:space)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    visit edit_space_path(space)
    click_link 'Add Image'

    within("#add_image") do
      click_button 'Upload'
    end

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Image can't be blank"
    expect(page).to have_content 'Your image has not been saved'
  end


end