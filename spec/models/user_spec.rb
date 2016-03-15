require 'rails_helper'

RSpec.describe User, type: :model do

  %w(email user_name).each do |attr|
    it "validates #{attr} presence" do
      should validate_presence_of attr
    end
  end

  it 'validates uniqueness of user_name' do
    should validate_uniqueness_of :user_name
  end

end