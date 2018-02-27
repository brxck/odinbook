class ReactionsController < ApplicationController
  def create
    same_reaction = current_user.reactions.where(reaction_params).take

    if same_reaction.nil?
      current_user.reactions.create(reaction_params)
    else
      same_reaction.destroy
    end

    redirect_back(fallback_location: root_path)
  end

  def show
    redirect_to url_for controller: reactable_type, action: :show, id: reactable_id
  end

  private

  def reaction_params
    params.require(:reaction).permit(:reactable_id, :reactable_type, :name)
  end
end
