require 'spec_helper'

feature 'User authorization' do
  scenario 'guest cannot visit admin page' do
    visit adminz_path

    expect(page).to have_content 'Not Authorized.'
    expect(current_path).to eq root_path
  end

  scenario 'superadmin user can view admin page' do
    user = create(:user, superadmin: true)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'

    visit adminz_path
    
    expect(page).to have_content 'This is the admin page.'
    expect(current_path).to_not eq root_path
  end
end