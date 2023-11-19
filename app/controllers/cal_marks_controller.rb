class CalMarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @cal_marks = CalMark.all.order(id: :desc)
  end

  def new
    @cal_mark = CalMark.new
  end

  def create
    @cal_mark = CalMark.new(cal_mark_params)

    if @cal_mark.save
      redirect_to cal_marks_path, notice: '발열량 범위 셍성을 성공 하였습니다.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @cal_mark = CalMark.find(params[:id])
  end

  def update
    @cal_mark = CalMark.find(params[:id])

    if @cal_mark.update(cal_mark_params)
      redirect_to cal_marks_path, notice: '발열량 범위 수정을 성공 하였습니다.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @cal_mark = CalMark.find(params[:id])
    @cal_mark.destroy
    flash[:notice] = '발열량 범위 삭제를 성공 하였습니다..'
    redirect_to cal_marks_path, status: :see_other
  end

  def checked
    use_params = params[:use]
    CalMark.update_all(use: false)
    flash[:notice] = "선택이 취소 되었습니다."
    if use_params
      use_params.each do |id, value|
        if value == 'true'
          cal_mark = CalMark.find(id)
          cal_mark.update(use: true)
          flash[:notice] = "#{cal_mark.title} 이(가) 선택 되었습니다."
        end
      end
    end
    redirect_to cal_marks_path, status: :see_other
  end

  private
  def cal_mark_params
    params.require(:cal_mark).permit!
  end
end
