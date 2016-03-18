# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Rails.env.development?
  (1..10).each do |i|
    user = User.find_by(user_name: "test_#{i}") || User.create(email: "test_#{i}@test.com", user_name: "test_#{i}", password: "12345", password_confirmation: "12345")
    user.follow(user)
    user.messages.create(content: "Hello world, I'm ##{i} user!") unless user.messages.present?
  end
end
