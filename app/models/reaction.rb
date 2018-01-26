class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user, :post, :type, presence: true
end
