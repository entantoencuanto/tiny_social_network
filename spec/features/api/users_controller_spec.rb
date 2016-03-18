require 'rails_helper'

feature 'api users controller' do
  before do
    5.times {FactoryGirl.create(:user)}
    @followed = FactoryGirl.create(:user, user_name: 'followed_user_name')
    User.all.each { |user| user.follow(@followed) }
  end

  scenario 'GET /api/users' do
    visit api_users_path

    expect(page).to have_http_status :success

    json = JSON.parse page.text
    expect(json.has_key?'data').to be true
    expect(json['data'].count).to eq(6)
    expect(page).to have_content('followed_user_name')
  end

  scenario 'GET /api/users/1' do
    visit api_user_path(@followed)

    expect(page).to have_http_status :success

    json = JSON.parse page.text
    expect(json.has_key?'data').to be true
    expect(json['data']['attributes']['user_name']).to eq('followed_user_name')
  end

  scenario 'GET /api/users/1/followeds' do
    visit api_user_followeds_path(@followed)

    expect(page).to have_http_status :success

    json = JSON.parse page.text
    expect(json.has_key?'data').to be true
    expect(json['data'].count).to eq(1)
    expect(page).to have_content('followed_user_name')
  end

  scenario 'GET /api/users/1/followers' do
    visit api_user_followers_path(@followed)

    expect(page).to have_http_status :success

    json = JSON.parse page.text
    expect(json.has_key?'data').to be true
    expect(json['data'].count).to eq(6)
    expect(page).to have_content('followed_user_name')
  end


end
