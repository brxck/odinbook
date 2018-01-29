class AddIndexToReactionName < ActiveRecord::Migration[5.1]
  def change
    add_index :reactions, :name
  end
end
