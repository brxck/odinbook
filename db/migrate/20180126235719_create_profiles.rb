class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.integer :age
      t.string :location
      t.text :intro
      t.string :kind

      t.timestamps
    end
  end
end
