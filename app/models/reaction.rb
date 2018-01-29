class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactable, polymorphic: true

  validates :user, :reactable, :name, presence: true
  
  before_create :delete_other_reaction

  def delete_other_reaction
    if (other_reaction = Reaction.where(user_id: user_id, reactable: reactable).first)
      other_reaction.destroy
    end
  end
end
