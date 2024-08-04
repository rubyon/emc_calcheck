class AddBurnedAtToBoxes < ActiveRecord::Migration[7.1]
  def change
    add_column :boxes, :burned_at, :datetime
  end
end
