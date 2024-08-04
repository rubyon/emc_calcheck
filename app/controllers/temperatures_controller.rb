require 'csv'

class TemperaturesController < ApplicationController

  def index
    if params[:daterange].present?
      date_range = params[:daterange].split(" - ")
      start_date = DateTime.strptime(date_range[0], "%m/%d %H:%M") - 9.hours
      end_date = DateTime.strptime(date_range[1], "%m/%d %H:%M") - 9.hours
    else
      start_date = DateTime.now.beginning_of_day
      end_date = DateTime.now.beginning_of_hour + 1.hours
    end
    @pagy, @temperatures = pagy(Temperature.where(created_at: start_date...end_date).order(id: :desc))
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
    @temperatures = Temperature.where(created_at: start_date...end_date).order(id: :asc)
    bom = "\uFEFF"
    # csv = CSV.generate(bom, col_sep: ',') do |csv|
    #   csv << ["TE102", "TE101", "PM101", "FM104", "FM104 T", "FM101A", "FM101A T", "FM101B", "FM101B T", "FM102A", "FM102A T", "FM102B", "FM102B T", "FM103", "FM103 T", "created"]
    #   @temperatures.each do |t|
    #     csv << [t.temp_0,
    #             t.temp_1,
    #             t.temp_2,
    #             t.temp_3,
    #             t.temp_4,
    #             t.temp_5,
    #             t.temp_6,
    #             t.temp_7,
    #             t.temp_8,
    #             t.temp_9,
    #             t.temp_10,
    #             t.temp_11,
    #             t.temp_12,
    #             t.temp_13,
    #             t.temp_14,
    #             t.created_at.localtime.strftime("%Y-%m-%d %H:%M:%S")]
    #   end
    # end

    csv = CSV.generate(bom, col_sep: ',') do |csv|
      csv << ["TE102", "TE101", "PM101", "FM104", "FM101A", "FM101B", "FM102A","FM102B", "FM103", "created"]
      @temperatures.each do |t|
        csv << [t.temp_0,
                t.temp_1,
                t.temp_2,
                t.temp_3,
                t.temp_5,
                t.temp_7,
                t.temp_9,
                t.temp_11,
                t.temp_13,
                t.created_at.localtime.strftime("%Y-%m-%d %H:%M:%S")]
      end
    end

    send_data csv, filename: "temperatures_#{params[:daterange]}.csv"
  end
end
