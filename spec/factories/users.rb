FactoryGirl.define do
  factory :user do
    email "test@test.com"
    password "1234567890"
    password_confirmation "1234567890"
    user_name { generate :user_name }
  end

  sequence :user_name do |n|
    "user_name_#{n}"
  end

end
