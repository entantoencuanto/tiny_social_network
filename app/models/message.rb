class Message < ActiveRecord::Base
  validates :content, presence: true,
                      length:   { maximum: 160 }
  validates :user,    presence: true

  belongs_to :user
end
