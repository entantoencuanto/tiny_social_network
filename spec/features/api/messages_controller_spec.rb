require 'rails_helper'

feature 'api messages controller' do
  before do
    5.times {FactoryGirl.create(:message)}
    @user = FactoryGirl.create(:user)
    @message = @user.messages.create(content: 'OK, computer')
  end

  scenario 'GET /api/messages/1' do
    visit api_message_path(@message)

    expect(page).to have_http_status :success

    json = JSON.parse page.text
    expect(json.has_key?'data').to be true
    expect(json['data']['attributes']['content']).to eq('OK, computer')
  end

  scenario 'GET /api/users/1/messages' do
    visit api_user_messages_path(@user)

    expect(page).to have_http_status :success

    json = JSON.parse page.text
    expect(json.has_key?'data').to be true
    expect(json['data'].count).to eq(1)
    expect(json['data'].first['attributes']['content']).to eq('OK, computer')
  end
end
