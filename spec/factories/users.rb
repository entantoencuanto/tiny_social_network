FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password_digest "MyString"
    user_name "MyString"
  end
end
