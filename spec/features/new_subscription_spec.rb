require 'spec_helper'

feature 'User subscribes' do
  scenario 'signs up for subscription', js: true do
    user = create(:user)
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'


    visit new_subscription_path
    click_button 'Pay with Card'
    fill_in 'paymentNumber', with: '4242424242424242'
    fill_in 'Expires', with: '01/15'
    fill_in 'paymentName', with: 'Ima Stoat'
    fill_in 'Card code', with: '123'
    click_button 'Pay'

    expect(page).to have_content 'You have Subscribed'
    save_and_open_page

  end
end