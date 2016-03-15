FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password "1234567890"
    password_confirmation "1234567890"
    user_name "MyString"
  end
end
