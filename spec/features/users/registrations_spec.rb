require 'rails_helper'

feature 'users registration' do
  scenario 'sign_up' do
    visit new_registrations_path

    expect(page).to have_http_status :success

    fill_in 'Email',                 with: 'test@test.com'
    fill_in 'User name',             with: 'test_user'
    fill_in 'Password',              with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Create User'

    expect(page).to have_http_status :success
    expect(User.find_by(user_name: 'test_user')).to be_present
  end
end
