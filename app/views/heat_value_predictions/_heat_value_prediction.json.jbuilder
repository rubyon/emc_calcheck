json.extract! heat_value_prediction, :id, :total_predicted_heat, :total_combustion_air_heat, :total_aux_fuel_heat, :total_exhaust_gas_heat, :total_heat_loss, :total_residual_ash_heat, :total_unburned_carbon_heat, :actual_heat_value, :heat_value_pred_accuracy, :prev_heat_value_pred_accuracy, :avg_heat_value_pred_accuracy, :created_at, :updated_at
json.url heat_value_prediction_url(heat_value_prediction, format: :json)
