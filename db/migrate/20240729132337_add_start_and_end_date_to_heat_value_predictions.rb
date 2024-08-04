class AddStartAndEndDateToHeatValuePredictions < ActiveRecord::Migration[7.1]
  def change
    add_column :heat_value_predictions, :start_date, :datetime
    add_column :heat_value_predictions, :end_date, :datetime
  end
end
