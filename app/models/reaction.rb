class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :reactable, polymorphic: true

  has_many :notifications, as: :notifiable, dependent: :destroy

  validates :user, :reactable, :name, presence: true
  
  before_create :delete_other_reaction
  after_create :notify

  def delete_other_reaction
    other_reaction = Reaction.where(user_id: user_id, reactable: reactable).take
    other_reaction.destroy if other_reaction
  end

  def notify
    body_text = "#{user.name} #{name}ed your #{reactable_type.downcase}."
    notifications.create(user_id: reactable.user.id,
                         body: body_text)
  end
end
