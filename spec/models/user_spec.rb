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

  context 'followers' do

    it '#follow' do
      follower = FactoryGirl.create(:user, user_name: 'follower')
      followed = FactoryGirl.create(:user, user_name: 'followed')
      follower.follow(followed)

      expect(follower.followeds).to include(followed)
      expect(followed.followers).to include(follower)
    end

    it '#unfollow' do
      follow = FactoryGirl.create(:follow)
      follower = follow.follower
      followed = follow.followed
      follower.unfollow(followed)

      expect(follower.followeds).to_not include(followed)
      expect(followed.followers).to_not include(follower)
    end
  end

end
