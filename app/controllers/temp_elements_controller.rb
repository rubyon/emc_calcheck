class TempElementsController < ApplicationController
  before_action :authenticate_user!

  def index
    @temp_elements = TempElement.all.order(id: :desc)
  end

  def new
    @temp_element = TempElement.new
  end

  def create
    @temp_element = TempElement.new(temp_element_params)

    if @temp_element.save
      redirect_to temp_elements_path, notice: '임시 성분 생성을 성공 하였습니다.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @temp_element = TempElement.find(params[:id])
  end

  def update
    @temp_element = TempElement.find(params[:id])

    if @temp_element.update(temp_element_params)
      redirect_to temp_elements_path, notice: '임시 성분 수정을 성공 하였습니다.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @temp_element = TempElement.find(params[:id])
    @temp_element.destroy
    flash[:notice] = '임시 성분 삭제를 성공 하였습니다.'
    redirect_to temp_elements_path, status: :see_other
  end

  def checked
    use_params = params[:use]
    TempElement.update_all(use: false)
    flash[:notice] = "선택이 취소 되었습니다."
    if use_params
      use_params.each do |id, value|
        if value == 'true'
          temp_element = TempElement.find(id)
          temp_element.update(use: true)
          flash[:notice] = "#{temp_element.title} 이(가) 선택 되었습니다."
        end
      end
    end
    redirect_to temp_elements_path, status: :see_other
  end

  private
  def temp_element_params
    params.require(:temp_element).permit!
  end
end
