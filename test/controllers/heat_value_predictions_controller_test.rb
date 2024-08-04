require "test_helper"

class HeatValuePredictionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @heat_value_prediction = heat_value_predictions(:one)
  end

  test "should get index" do
    get heat_value_predictions_url
    assert_response :success
  end

  test "should get new" do
    get new_heat_value_prediction_url
    assert_response :success
  end

  test "should create heat_value_prediction" do
    assert_difference("HeatValuePrediction.count") do
      post heat_value_predictions_url, params: { heat_value_prediction: { actual_heat_value: @heat_value_prediction.actual_heat_value, avg_heat_value_pred_accuracy: @heat_value_prediction.avg_heat_value_pred_accuracy, heat_value_pred_accuracy: @heat_value_prediction.heat_value_pred_accuracy, prev_heat_value_pred_accuracy: @heat_value_prediction.prev_heat_value_pred_accuracy, total_aux_fuel_heat: @heat_value_prediction.total_aux_fuel_heat, total_combustion_air_heat: @heat_value_prediction.total_combustion_air_heat, total_exhaust_gas_heat: @heat_value_prediction.total_exhaust_gas_heat, total_heat_loss: @heat_value_prediction.total_heat_loss, total_predicted_heat: @heat_value_prediction.total_predicted_heat, total_residual_ash_heat: @heat_value_prediction.total_residual_ash_heat, total_unburned_carbon_heat: @heat_value_prediction.total_unburned_carbon_heat } }
    end

    assert_redirected_to heat_value_prediction_url(HeatValuePrediction.last)
  end

  test "should show heat_value_prediction" do
    get heat_value_prediction_url(@heat_value_prediction)
    assert_response :success
  end

  test "should get edit" do
    get edit_heat_value_prediction_url(@heat_value_prediction)
    assert_response :success
  end

  test "should update heat_value_prediction" do
    patch heat_value_prediction_url(@heat_value_prediction), params: { heat_value_prediction: { actual_heat_value: @heat_value_prediction.actual_heat_value, avg_heat_value_pred_accuracy: @heat_value_prediction.avg_heat_value_pred_accuracy, heat_value_pred_accuracy: @heat_value_prediction.heat_value_pred_accuracy, prev_heat_value_pred_accuracy: @heat_value_prediction.prev_heat_value_pred_accuracy, total_aux_fuel_heat: @heat_value_prediction.total_aux_fuel_heat, total_combustion_air_heat: @heat_value_prediction.total_combustion_air_heat, total_exhaust_gas_heat: @heat_value_prediction.total_exhaust_gas_heat, total_heat_loss: @heat_value_prediction.total_heat_loss, total_predicted_heat: @heat_value_prediction.total_predicted_heat, total_residual_ash_heat: @heat_value_prediction.total_residual_ash_heat, total_unburned_carbon_heat: @heat_value_prediction.total_unburned_carbon_heat } }
    assert_redirected_to heat_value_prediction_url(@heat_value_prediction)
  end

  test "should destroy heat_value_prediction" do
    assert_difference("HeatValuePrediction.count", -1) do
      delete heat_value_prediction_url(@heat_value_prediction)
    end

    assert_redirected_to heat_value_predictions_url
  end
end
