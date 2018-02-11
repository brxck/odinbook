class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  validate :not_self
  validate :not_friends
  validate :not_pending

  after_create :request_notify
  after_update :acceptance_notify

  # Add friend through friendship association and destroy friend request.
  def accept
    user.friends << friend
    destroy
  end

  private

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end

  def not_friends
    errors.add(:friend, "is already added") if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, "already requested") if friend.pending_friends.include?(user)
  end

  def request_notify
    notifications.create(user_id: friend_id,
                         body: "#{user.name} sent you a friend request!")
  end

  def acceptance_notify
    notifications.create(user_id: user_id,
                         body: "You're now friends with #{friend.name}!")
  end
end
