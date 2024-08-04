class CreateHeatValuePredictions < ActiveRecord::Migration[7.1]
  def change
    create_table :heat_value_predictions do |t|
      t.float :total_predicted_heat
      t.float :total_combustion_air_heat
      t.float :total_aux_fuel_heat
      t.float :total_exhaust_gas_heat
      t.float :total_heat_loss
      t.float :total_residual_ash_heat
      t.float :total_unburned_carbon_heat
      t.float :actual_heat_value
      t.float :heat_value_pred_accuracy
      t.float :prev_heat_value_pred_accuracy
      t.float :avg_heat_value_pred_accuracy

      t.timestamps
    end
  end
end
