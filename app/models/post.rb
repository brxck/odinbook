class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  validates :author, :body, presence: true
end
