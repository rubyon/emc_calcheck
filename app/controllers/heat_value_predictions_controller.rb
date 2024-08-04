class HeatValuePredictionsController < ApplicationController
  before_action :set_heat_value_prediction, only: %i[ show edit update destroy ]

  # GET /heat_value_predictions or /heat_value_predictions.json
  def index
    @heat_value_predictions = HeatValuePrediction.order(created_at: :desc).all
  end

  # GET /heat_value_predictions/1 or /heat_value_predictions/1.json
  def show
  end

  # GET /heat_value_predictions/new
  def new
    @heat_value_prediction = HeatValuePrediction.new
  end

  # GET /heat_value_predictions/1/edit
  def edit
  end

  # POST /heat_value_predictions or /heat_value_predictions.json
  def create
    @heat_value_prediction = HeatValuePrediction.new(heat_value_prediction_params)

    respond_to do |format|
      if @heat_value_prediction.save
        format.html { redirect_to heat_value_prediction_url(@heat_value_prediction), notice: "Heat value prediction was successfully created." }
        format.json { render :show, status: :created, location: @heat_value_prediction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @heat_value_prediction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /heat_value_predictions/1 or /heat_value_predictions/1.json
  def update
    respond_to do |format|
      if @heat_value_prediction.update(heat_value_prediction_params)
        format.html { redirect_to heat_value_prediction_url(@heat_value_prediction), notice: "Heat value prediction was successfully updated." }
        format.json { render :show, status: :ok, location: @heat_value_prediction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @heat_value_prediction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /heat_value_predictions/1 or /heat_value_predictions/1.json
  def destroy
    @heat_value_prediction.destroy!

    respond_to do |format|
      format.html { redirect_to heat_value_predictions_url, notice: "Heat value prediction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_heat_value_prediction
      @heat_value_prediction = HeatValuePrediction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def heat_value_prediction_params
      params.require(:heat_value_prediction).permit(:total_predicted_heat, :total_combustion_air_heat, :total_aux_fuel_heat, :total_exhaust_gas_heat, :total_heat_loss, :total_residual_ash_heat, :total_unburned_carbon_heat, :actual_heat_value, :heat_value_pred_accuracy, :prev_heat_value_pred_accuracy, :avg_heat_value_pred_accuracy)
    end
end
