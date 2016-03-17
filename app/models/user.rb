class User < ActiveRecord::Base
  validates :email,     presence:   true
  validates :user_name, presence:   true,
                        uniqueness: true
  has_secure_password

  has_many :messages, dependent: :destroy
  has_many :followed_follows, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  has_many :follower_follows, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy

  def to_s
    user_name
  end
end
