class CreateCalMarks < ActiveRecord::Migration[7.1]
  def change
    create_table :cal_marks do |t|
      t.string :title
      t.integer :low
      t.integer :middle
      t.boolean :use

      t.timestamps
    end
  end
end
