class FormulasController < ApplicationController
  before_action :authenticate_user!

  def index
    @formulas = Formula.all
  end

  def new
    @formula = Formula.new
  end

  def create
    @formula = Formula.new(formula_params)

    if @formula.save
      redirect_to elements_path, notice: '발열량 계산식 생성을 성공 하였습니다.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @formula = Formula.find(params[:id])
  end

  def update
    @formula = Formula.find(params[:id])

    if @formula.update(formula_params)
      redirect_to formulas_path, notice: '발열량 계산식 수정을 성공 하였습니다.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def formula_params
    modified_params = params.require(:formula).permit!
    # 모든 파라미터 키를 소문자로 변경
    modified_params.transform_values!(&:downcase)
    modified_params
  end

end
