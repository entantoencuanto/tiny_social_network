class User < ActiveRecord::Base
  validates :email,     presence:   true
  validates :user_name, presence:   true,
                        uniqueness: true
  has_secure_password

  has_many :messages, dependent: :destroy
end
