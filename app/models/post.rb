class Post < ApplicationRecord
  belongs_to :user

  has_many :comments, as: :commentable, dependent: :destroy
  has_many :reactions, as: :reactable, dependent: :destroy

  validates :user, :body, presence: true

  def blessings
    reactions.where(name: "bless")
  end

  def smitings
    reactions.where(name: "smite")
  end
end
