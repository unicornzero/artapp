require 'spec_helper'

  #load stripe api keys based on environment
  #path for subscription cancellation
  #path for if card charge fails
  #subscribed user can edit more fields
  #subscribed user can publish pro version of space

feature 'Subscription' do
  scenario 'page owner sees subscription menu' do
    user = create(:user)
    space = create(:space, user_id: user.id, plan: 'Basic')
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    visit '/account'

    click_link 'Manage Subscription'

    expect(page).to have_content 'Current Plan: Basic'
  end

  scenario 'page owner can upgrade subscription', js: true do
    user = create(:user)
    space = create(:space, user_id: user.id, plan: 'Basic')
    visit root_path
    click_link 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log In'
    visit '/account'
    click_link 'Manage Subscription'

    click_button 'Pay with Card'
    fill_in 'paymentNumber', with: '4242424242424242'
    fill_in 'Expires', with: '01/15'
    fill_in 'paymentName', with: 'R. B. Gumbo'
    fill_in 'Card code', with: '123'
    click_button 'Pay'

    expect(page).to have_content 'Your account has been upgraded to Pro!'
    click_link 'Manage Subscription'

    expect(page).to have_content 'Current Plan: Pro'
  end
end