FactoryGirl.define do
  factory :message do
    content "MyString"
    association :user, factory: :user
  end
end
