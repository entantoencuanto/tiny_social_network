class Message < ActiveRecord::Base
  validates :content, presence: true,
                      length:   { maximum: 160 }
  validates :user,    presence: true

  belongs_to :user

  def can_be_deleted_by?(user)
    user == self.user
  end
end
