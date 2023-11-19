class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:calcheck]

  def calcheck
    begin
      json_params = JSON.parse(request.raw_post)
      category = Category.find_by_code(json_params["code"])
      weight = json_params["weight"].to_f

      formula = Formula.last

      # TempElement 를 사용하고 있는지 확인
      if TempElement.where(use: true).size > 0
        element = TempElement.where(use: true).first
        @box_cal_hi = element.instance_eval(formula.hhv_formula) * weight
        @box_cal_low = element.instance_eval(formula.lhv_formula) * weight
        @hhv = element.instance_eval(formula.hhv_formula)
        @lhv = element.instance_eval(formula.lhv_formula)
      else
        element = Element.where(category_id: category.id, season: get_season).last
        # lhv_temp 값을 확인
        if element.hhv_temp.blank?
          @box_cal_hi = element.instance_eval(formula.hhv_formula) * weight
          @hhv = element.instance_eval(formula.hhv_formula)
        else
          @box_cal_hi = element.hhv_temp * weight
          @hhv = element.hhv_temp
        end

        if element.lhv_temp.blank?
          @box_cal_low = element.instance_eval(formula.lhv_formula) * weight
          @lhv = element.instance_eval(formula.lhv_formula)
        else
          @box_cal_low = element.lhv_temp * weight
          @lhv = element.lhv_temp
        end
      end

      @range = CalMark.where(use: true).first

      if @range.blank?
        @range = CalMark.last
      end

      @marks = 0

      if @box_cal_low >= 0 && @box_cal_low <= @range.low
        @marks = 1
      elsif @box_cal_low >= 10001 && @box_cal_low <= @range.middle
        @marks = 2
      elsif @box_cal_low >= 20001
        @marks = 3
      else
        @marks = 0
      end

      @box = Box.new
      @box.epc = json_params["epc"]
      @box.kkr = json_params["kkr"]
      @box.category = category
      @box.deadline = DateTime.now
      @box.weight = weight
      @box.hhv = @hhv
      @box.lhv = @lhv
      @box.box_cal_hi = @box_cal_hi
      @box.box_cal_low = @box_cal_low
      @box.marks = @marks

      @box.save

    rescue
      @low = 0
      @marks = 0
    end

    render json: {
      code: Category.find_by_code(json_params["code"]).name,
      weight: weight,
      low: @box_cal_low,
      marks: @marks
    }
  end
end
