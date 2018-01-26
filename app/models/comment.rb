class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :reactions

  validates :user, :commentable, :body, presence: true
end
