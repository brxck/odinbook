class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :friend_requests
  has_many :pending_friends, through: :friend_requests

  has_many :posts
  has_many :comments
  has_many :likes

  has_one :profile
end
