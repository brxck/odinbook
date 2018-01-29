class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true

  has_many :reactions, as: :reactable, dependent: :destroy

  validates :user, :commentable, :body, presence: true

  def reaction(name)
    reactions.where(name: name)
  end

  def blessings
    reactions.where(name: "bless")
  end

  def smitings
    reactions.where(name: "smite")
  end
end
