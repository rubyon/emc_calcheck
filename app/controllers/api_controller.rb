class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:calcheck]

  def calcheck
    begin
      json_params = JSON.parse(request.raw_post)
      category = Category.find_by_code(json_params["category"])
      weight = json_params["weight"]

      formula = Formula.last

      # TempElement 를 사용하고 있는지 확인
      if TempElement.where(use: true).size > 0
        element = TempElement.where(use: true).first
        @result = element.instance_eval(formula.lhv_formula) * weight
      else
        element = Element.where(category_id: category.id, season: get_season).order(created_at: :desc).first
        # lhv_temp 값을 확인

        if element.lhv_temp.blank?
          @result = element.instance_eval(formula.lhv_formula) * weight
        else
          @result = element.lhv_temp * weight
        end

      end

      puts "TEST: #{element.inspect}"

      @range = CalMark.where(use: true).first

      if @range.blank?
        @range = CalMark.last
      end

      @marks = 0

      if @result >= 0 && @result <= @range.low
        @marks = 1
      elsif @result >= 10001 && @result <= @range.middle
        @marks = 2
      elsif @result >= 20001
        @marks = 3
      else
        @marks = 0
      end

    rescue
      @result = 0
    end

    puts @result

    render json: { result: @result, marks: @marks }
  end
end
