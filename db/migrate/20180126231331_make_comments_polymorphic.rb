class MakeCommentsPolymorphic < ActiveRecord::Migration[5.1]
  def change
    remove_reference :comments, :post
    add_reference :comments, :commentable, polymorphic: true
  end
end
