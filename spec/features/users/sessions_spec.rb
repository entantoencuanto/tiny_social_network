require 'rails_helper'

feature 'users sessions' do
  before do
    @user = FactoryGirl.create(:user, user_name: 'test_user_name', password: 'test1234', password_confirmation: 'test1234')
  end

  scenario 'successful sign_in' do
    visit sign_in_path

    fill_in 'User name', with: 'test_user_name'
    fill_in 'Password',  with: 'test1234'
    click_button 'Sign in'

    expect(page).to have_http_status :success
    expect(page).to have_content('test_user_name')
  end


  scenario 'failed sign_in' do
    visit sign_in_path

    fill_in 'User name', with: 'test_user_name'
    fill_in 'Password',  with: 'fail'
    click_button 'Sign in'

    expect(page).to have_http_status :success
    expect(page).to have_content('Unauthorized')
  end

  scenario 'sign_out' do
    visit sign_in_path

    fill_in 'User name', with: 'test_user_name'
    fill_in 'Password',  with: 'test1234'
    click_button 'Sign in'

    click_link 'Sign out'
    expect(page).to have_http_status :success
    expect(page).to have_content('Sign in')
  end
end

