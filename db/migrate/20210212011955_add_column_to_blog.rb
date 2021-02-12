class AddColumnToBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :price, :integer
    add_reference :blogs, :category, foreign_key: true
  end
end
