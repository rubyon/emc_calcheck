class CreateFormulas < ActiveRecord::Migration[7.1]
  def change
    create_table :formulas do |t|
      t.string :hhv_formula
      t.string :lhv_formula

      t.timestamps
    end
  end
end
