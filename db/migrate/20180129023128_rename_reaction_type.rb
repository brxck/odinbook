class RenameReactionType < ActiveRecord::Migration[5.1]
  def change
    rename_column :reactions, :type, :name
  end
end
