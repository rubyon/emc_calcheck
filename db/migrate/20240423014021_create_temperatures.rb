class CreateTemperatures < ActiveRecord::Migration[7.1]
  def change
    create_table :temperatures do |t|
      t.float :temp_0
      t.float :temp_1
      t.float :temp_2
      t.float :temp_3
      t.float :temp_4
      t.float :temp_5
      t.float :temp_6
      t.float :temp_7
      t.float :temp_8
      t.float :temp_9
      t.float :temp_10
      t.float :temp_11
      t.float :temp_12
      t.float :temp_13
      t.float :temp_14

      t.timestamps
    end
  end
end
