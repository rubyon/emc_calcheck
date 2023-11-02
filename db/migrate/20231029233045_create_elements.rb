class CreateElements < ActiveRecord::Migration[7.1]
  def change
    create_table :elements do |t|
      t.float :w
      t.float :f
      t.float :a
      t.float :c
      t.float :h
      t.float :o
      t.float :n
      t.float :s
      t.float :cl
      t.string :season
      t.float :hhv_temp
      t.float :lhv_temp

      t.timestamps
    end
  end
end
