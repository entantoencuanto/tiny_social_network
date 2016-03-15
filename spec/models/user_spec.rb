require 'rails_helper'

RSpec.describe User, type: :model do

  it 'has a valid factory' do
    user = FactoryGirl.build(:user)
    expect(user).to be_valid
  end

  %w(email user_name).each do |attr|
    it "validates #{attr} presence" do
      should validate_presence_of attr
    end
  end

  it 'validates uniqueness of user_name' do
    should validate_uniqueness_of :user_name
  end

  it 'has secure password provided by ActiveModel' do
    should have_secure_password
  end

end
