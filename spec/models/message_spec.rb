require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'has a valid factory' do
    message = FactoryGirl.build(:message)
    expect(message).to be_valid
  end

  %w(user content).each do |attr|
    it "validates #{attr} presence" do
      should validate_presence_of attr
    end
  end

  it 'validates maximum length of message' do
    should validate_length_of(:content).is_at_most(160)
  end

  it 'belongs to user' do
    should belong_to(:user)
  end
end
