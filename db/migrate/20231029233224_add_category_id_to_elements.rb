class AddCategoryIdToElements < ActiveRecord::Migration[7.1]
  def change
    add_reference :elements, :category, null: false, foreign_key: true
  end
end
