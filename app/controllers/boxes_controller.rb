class BoxesController < ApplicationController

  def index
    if params[:daterange].present?
      date_range = params[:daterange].split(" - ")
      start_date = DateTime.strptime(date_range[0], "%m/%d %H:%M") - 9.hours
      end_date = DateTime.strptime(date_range[1], "%m/%d %H:%M") - 9.hours
    else
      start_date = DateTime.now.beginning_of_day
      end_date = DateTime.now.beginning_of_hour + 1.hours
    end
    @pagy, @boxes = pagy(Box.where(created_at: start_date...end_date).order(id: :desc))
  end

  def boxes_cal
    if params[:daterange].present?
      date_range = params[:daterange].split(" - ")
      start_date = DateTime.strptime(date_range[0], "%m/%d %H:%M") - 9.hours
      end_date = DateTime.strptime(date_range[1], "%m/%d %H:%M") - 9.hours
    else
      start_date = DateTime.now.beginning_of_day
      end_date = DateTime.now.beginning_of_hour + 1.hours
    end
    @boxes = Box.where(burned_at: start_date...end_date).order(id: :asc)
    @sensors = Temperature.where(created_at: start_date...end_date).order(id: :asc)
    @total_box_cal_low = @boxes.sum(:box_cal_low)
    @total_box_weight = @boxes.sum(:weight)

    @fm_104_average = @sensors.where('temp_3 > ?', 0).average(:temp_3).to_f.round(2)
    @fm_104_size = @sensors.where('temp_3 > ?', 0).size

    @fm_101a_average = @sensors.where('temp_5 > ?', 0).average(:temp_5).to_f.round(2)
    @fm_101a_size = @sensors.where('temp_5 > ?', 0).size

    @fm_101b_average = @sensors.where('temp_7 > ?', 0).average(:temp_7).to_f.round(2)
    @fm_101b_size = @sensors.where('temp_7 > ?', 0).size

    @fm_102a_average = @sensors.where('temp_9 > ?', 0).average(:temp_9).to_f.round(2)
    @fm_102a_size = @sensors.where('temp_9 > ?', 0).size

    @fm_102b_average = @sensors.where('temp_11 > ?', 0).average(:temp_11).to_f.round(2)
    @fm_102b_size = @sensors.where('temp_11 > ?', 0).size

    @fm_103_average = @sensors.where('temp_13 > ?', 0).average(:temp_13).to_f.round(2)
    @fm_103_size = @sensors.where('temp_13 > ?', 0).size

  end

  def boxes_update
    if params[:daterange].present?
      date_range = params[:daterange].split(" - ")
      start_date = DateTime.strptime(date_range[0], "%m/%d %H:%M") - 9.hours
      end_date = DateTime.strptime(date_range[1], "%m/%d %H:%M") - 9.hours
      @boxes = Box.where(created_at: start_date...end_date).order(id: :asc)
    else
      @boxes = []
    end
  end

  def boxes_update_ok
    date_range = params[:daterange].split(" - ")
    start_date = DateTime.strptime(date_range[0], "%m/%d %H:%M") - 9.hours
    end_date = DateTime.strptime(date_range[1], "%m/%d %H:%M") - 9.hours
    @boxes = Box.where(created_at: start_date...end_date).order(id: :asc)

    burned_daterange = params[:burned_daterange].split(" - ")
    burned_start_date = DateTime.strptime(burned_daterange[0], "%m/%d %H:%M")
    burned_end_date = DateTime.strptime(burned_daterange[1], "%m/%d %H:%M")

    if params[:clear_all] == "1"

      @boxes.each do |box|
        box.update(burned_at: nil)
      end

    else

    # 처음과 마지막 -1 까지 burned_start_date 로 업데이트
    @boxes[0...-1].each do |box|
      box.update(burned_at: burned_start_date - 9.hours + 1.minutes)
    end
    # 마지막 요소는 burned_end_date 로 업데이트
    @boxes.last.update(burned_at: burned_end_date - 9.hours - 1.minutes)

    end
    # 데이터 레인지를 burned_start_date 와 burned_end_date 로 설정하여 리다이렉트
    redirect_to boxes_cal_path(daterange: "#{burned_start_date.strftime("%m/%d %H:%M")} - #{burned_end_date.strftime("%m/%d %H:%M")}", commit: "검색")
  end


  def boxes_cal_save
    last_prediction = HeatValuePrediction.order(created_at: :desc).first
    @heat_value_prediction = HeatValuePrediction.new(heat_value_prediction_params)

    @heat_value_prediction.prev_heat_value_pred_accuracy = last_prediction&.heat_value_pred_accuracy || 0.0

    if last_prediction.present?
      # 새로운 값을 포함하여 평균 계산
      total_accuracy = HeatValuePrediction.sum(:heat_value_pred_accuracy) + @heat_value_prediction.heat_value_pred_accuracy
      avg_accuracy = total_accuracy / (HeatValuePrediction.count + 1)
    else
      avg_accuracy = @heat_value_prediction.heat_value_pred_accuracy
    end

    @heat_value_prediction.avg_heat_value_pred_accuracy = avg_accuracy

    if @heat_value_prediction.save
      redirect_back(fallback_location: root_path, notice: '폐기물 발열량 계산 값이 성공적으로 저장되었습니다.')
    else
      redirect_back(fallback_location: root_path, alert: '폐기물 발열량 계산 값 저장에 실패했습니다.')
    end
  end





  def download
    if params[:daterange].present?
      date_range = params[:daterange].split(" - ")
      start_date = DateTime.strptime(date_range[0], "%m/%d %H:%M") - 9.hours
      end_date = DateTime.strptime(date_range[1], "%m/%d %H:%M") - 9.hours
    else
      start_date = DateTime.now.beginning_of_day
      end_date = DateTime.now.beginning_of_hour + 1.hours
    end
    @boxes = Box.where(created_at: start_date...end_date).order(id: :asc)
    bom = "\uFEFF"
    csv = CSV.generate(bom, col_sep: ',') do |csv|
      csv << ["epc", "kkr", "category", "deadLine", "weight", "hhv", "lhv", "box cal hi", "box cal low", "marks", "updated", "created", "burned"]
      @boxes.each do |t|
        csv << [t.epc,
                t.kkr,
                t.category.name,
                t.deadline,
                t.weight,
                t.hhv,
                t.lhv,
                t.box_cal_hi,
                t.box_cal_low,
                t.marks,
                t.updated_at.localtime.strftime("%Y-%m-%d %H:%M:%S"),
                t.created_at.localtime.strftime("%Y-%m-%d %H:%M:%S"),
                t.burned_at&.localtime&.strftime("%Y-%m-%d %H:%M:%S")]
      end
    end

    send_data csv, filename: "boxes_#{params[:daterange]}.csv"
  end

  private

  def heat_value_prediction_params
    params.permit(
      :total_predicted_heat,
      :total_combustion_air_heat,
      :total_aux_fuel_heat,
      :total_exhaust_gas_heat,
      :total_heat_loss,
      :total_residual_ash_heat,
      :total_unburned_carbon_heat,
      :actual_heat_value,
      :heat_value_pred_accuracy,
      :prev_heat_value_pred_accuracy,
      :avg_heat_value_pred_accuracy,
      :start_date,
      :end_date
    )
  end

end
