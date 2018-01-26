class Friendship < ApplicationRecord
  after_create :create_inverse
  after_destroy :destroy_inverse
  
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validate :not_self

  def create_inverse
    friend.friendships.create(friend: user)
  end

  def destroy_inverse
    friendship = friend.friendships.find_by(friend: user)
    friendship.destroy if friendship
  end

  private

  def not_self
    errors.add(:friend, "can't be equal to user") if user == friend
  end
end
