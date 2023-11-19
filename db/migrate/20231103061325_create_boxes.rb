class CreateBoxes < ActiveRecord::Migration[7.1]
  def change
    create_table :boxes do |t|
      t.string :epc
      t.string :kkr
      t.references :category, null: false, foreign_key: true
      t.datetime :deadline
      t.float :weight
      t.float :hhv
      t.float :lhv
      t.float :box_cal_hi
      t.float :box_cal_low
      t.integer :marks

      t.timestamps
    end
  end
end
