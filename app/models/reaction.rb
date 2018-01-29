class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactable, polymorphic: true

  validates :user, :reactable, :name, presence: true
  
  before_create :delete_other_reaction

  def delete_other_reaction
    other_reaction = Reaction.where(user_id: user_id, reactable: reactable).take
    other_reaction.destroy if other_reaction
  end
end
