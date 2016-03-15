class User < ActiveRecord::Base
  validates :email,     presence:   true
  validates :user_name, presence:   true,
                        uniqueness: true
end