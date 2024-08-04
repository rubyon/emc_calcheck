class ElementsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:category].present?
      @categories = Category.where( id: params[:category])
      @category_title = @categories.name
    else
      @categories = Category.all
      @category_title = '전체 보기'
    end
  end

  def new
    @categories = Category.all
    @element = Element.new
    if params[:category].present?
      @element.category_id = Category.find(params[:category]).id
      @category_title = Category.find(params[:category]).name
    end
    if params[:season].present?
      @element.season = params[:season]
      @season_title = translate_season(params[:season])
    end
  end

  def create
    @element = Element.new(element_params)

    if @element.save
      redirect_to elements_path(category: @element.category.id), notice: '성분 셍성을 성공 하였습니다..'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @categories = Category.all
    @element = Element.find(params[:id])
    @category_title = @element.category.name
    @season_title = translate_season(@element.season)
  end

  def update
    @element = Element.find(params[:id])

    if @element.update(element_params)
      redirect_to elements_path(category: @element.category.code), notice: '성분 수정을 성공 하였습니다.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @element = Element.find(params[:id])
    @element.destroy
    flash[:notice] = '성분 삭제를 성공 하였습니다.'
    redirect_to elements_path(category: @element.category.code), status: :see_other
  end

  private
  def element_params
    params.require(:element).permit!
  end
end
