class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reactions, as: :reactable, dependent: :destroy

  validates :user, :body, presence: true
  validates :link, url: { allow_blank: true }

  default_scope { order("created_at DESC") }

  include ReactionsHelper
end
