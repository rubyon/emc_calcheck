class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @range = CalMark.where(use: true).first
    @range = CalMark.all.order(id: :desc).first if @range.nil?
    @temp_element = TempElement.where(use: true).order(id: :desc).first
  end

end
