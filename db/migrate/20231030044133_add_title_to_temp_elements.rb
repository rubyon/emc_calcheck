class AddTitleToTempElements < ActiveRecord::Migration[7.1]
  def change
    add_column :temp_elements, :title, :string
  end
end
