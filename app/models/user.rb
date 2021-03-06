class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :friend_requests, dependent: :destroy
  has_many :pending_requests, class_name: "FriendRequest", foreign_key: :friend_id
  has_many :pending_friends, through: :friend_requests, source: :friend

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  has_many :notifications, dependent: :destroy

  has_one :profile, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  before_create :build_default_profile

  def remove_friend(friend)
    friends.destroy(friend)
  end

  private

  def build_default_profile
    build_profile
  end
end
