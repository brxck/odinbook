class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactable, polymorphic: true

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user, :reactable, :name, presence: true

  before_create :delete_other_reaction
  after_create :notify

  def delete_other_reaction
    other_reaction = Reaction.find_by(user_id: user_id, reactable: reactable)
    other_reaction&.destroy
  end

  def notify
    past_tense = { "smite" => "smited", "bless" => "blessed" }
    body_text = "#{user.name} #{past_tense[name]} your #{reactable_type.downcase}."
    notifications.create(user_id: reactable.user.id,
                         body: body_text)
  end

  def parent
    reactable
  end
end
