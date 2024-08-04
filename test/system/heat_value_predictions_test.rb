require "application_system_test_case"

class HeatValuePredictionsTest < ApplicationSystemTestCase
  setup do
    @heat_value_prediction = heat_value_predictions(:one)
  end

  test "visiting the index" do
    visit heat_value_predictions_url
    assert_selector "h1", text: "Heat value predictions"
  end

  test "should create heat value prediction" do
    visit heat_value_predictions_url
    click_on "New heat value prediction"

    fill_in "Actual heat value", with: @heat_value_prediction.actual_heat_value
    fill_in "Avg heat value pred accuracy", with: @heat_value_prediction.avg_heat_value_pred_accuracy
    fill_in "Heat value pred accuracy", with: @heat_value_prediction.heat_value_pred_accuracy
    fill_in "Prev heat value pred accuracy", with: @heat_value_prediction.prev_heat_value_pred_accuracy
    fill_in "Total aux fuel heat", with: @heat_value_prediction.total_aux_fuel_heat
    fill_in "Total combustion air heat", with: @heat_value_prediction.total_combustion_air_heat
    fill_in "Total exhaust gas heat", with: @heat_value_prediction.total_exhaust_gas_heat
    fill_in "Total heat loss", with: @heat_value_prediction.total_heat_loss
    fill_in "Total predicted heat", with: @heat_value_prediction.total_predicted_heat
    fill_in "Total residual ash heat", with: @heat_value_prediction.total_residual_ash_heat
    fill_in "Total unburned carbon heat", with: @heat_value_prediction.total_unburned_carbon_heat
    click_on "Create Heat value prediction"

    assert_text "Heat value prediction was successfully created"
    click_on "Back"
  end

  test "should update Heat value prediction" do
    visit heat_value_prediction_url(@heat_value_prediction)
    click_on "Edit this heat value prediction", match: :first

    fill_in "Actual heat value", with: @heat_value_prediction.actual_heat_value
    fill_in "Avg heat value pred accuracy", with: @heat_value_prediction.avg_heat_value_pred_accuracy
    fill_in "Heat value pred accuracy", with: @heat_value_prediction.heat_value_pred_accuracy
    fill_in "Prev heat value pred accuracy", with: @heat_value_prediction.prev_heat_value_pred_accuracy
    fill_in "Total aux fuel heat", with: @heat_value_prediction.total_aux_fuel_heat
    fill_in "Total combustion air heat", with: @heat_value_prediction.total_combustion_air_heat
    fill_in "Total exhaust gas heat", with: @heat_value_prediction.total_exhaust_gas_heat
    fill_in "Total heat loss", with: @heat_value_prediction.total_heat_loss
    fill_in "Total predicted heat", with: @heat_value_prediction.total_predicted_heat
    fill_in "Total residual ash heat", with: @heat_value_prediction.total_residual_ash_heat
    fill_in "Total unburned carbon heat", with: @heat_value_prediction.total_unburned_carbon_heat
    click_on "Update Heat value prediction"

    assert_text "Heat value prediction was successfully updated"
    click_on "Back"
  end

  test "should destroy Heat value prediction" do
    visit heat_value_prediction_url(@heat_value_prediction)
    click_on "Destroy this heat value prediction", match: :first

    assert_text "Heat value prediction was successfully destroyed"
  end
end
