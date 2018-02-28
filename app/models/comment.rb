class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :reactions, as: :reactable, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user, :commentable, :body, presence: true

  after_create :notify

  include ReactionsHelper

  def notify
    body_text = "#{user.name} commented on your #{commentable_type.downcase}."
    notifications.create(user_id: commentable.user.id,
                         body: body_text)
  end
end
