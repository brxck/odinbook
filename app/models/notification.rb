class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  validates :user, :notifiable, :body, presence: true
  validate :not_from_self

  def not_from_self
    if notifiable.user == user
      errors.add(:user, "can't send yourself a notification")
    end
  end
end
