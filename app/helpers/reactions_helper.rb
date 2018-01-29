module ReactionsHelper
  def reaction(name)
    reactions.where(name: name)
  end
end
