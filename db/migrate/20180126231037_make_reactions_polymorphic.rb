class MakeReactionsPolymorphic < ActiveRecord::Migration[5.1]
  def change
    remove_reference :reactions, :post
    add_reference :reactions, :reactable, polymorphic: true
  end
end
