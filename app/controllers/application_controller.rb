class ApplicationController < ActionController::Base
  include Pagy::Backend

  before_action :load_categories

  def get_season
    month = Time.now.month
    case month
    when 3, 4, 5
      "spring"
    when 6, 7, 8
      "summer"
    when 9, 10, 11
      "autumn"
    when 12, 1, 2
      "winter"
    else
      "error"
    end
  end

  def translate_season(season)
    case season
    when 'spring'
      '봄'
    when 'summer'
      '여름'
    when 'autumn'
      '가을'
    when 'winter'
      '겨울'
    else
      '계절을 찾을 수 없습니다'
    end
  end

  private
  def load_categories
    @categories_all = Category.all
  end
end
