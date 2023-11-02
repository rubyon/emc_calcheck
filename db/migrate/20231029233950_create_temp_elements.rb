class CreateTempElements < ActiveRecord::Migration[7.1]
  def change
    create_table :temp_elements do |t|
      t.float :w
      t.float :f
      t.float :a
      t.float :c
      t.float :h
      t.float :o
      t.float :n
      t.float :s
      t.float :cl
      t.boolean :use

      t.timestamps
    end
  end
end
