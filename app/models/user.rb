class User < ActiveRecord::Base
  validates :email,     presence:   true
  validates :user_name, presence:   true,
                        uniqueness: true
  has_secure_password

  has_many :messages, dependent: :destroy
  has_many :followed_follows, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy
  has_many :follower_follows, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy

  has_many :followers, through: :follower_follows, source: :follower
  has_many :followeds, through: :followed_follows, source: :followed

  has_many :followed_messages, through: :followeds, source: :messages

  def to_s
    user_name
  end

  def follow(user)
    self.followeds << user unless self.followeds.include?(user)
  end

  def unfollow(user)
    self.followeds.destroy(user)
  end

  def total_followeds
    followeds.count
  end

  def total_followers
    followers.count
  end

end
