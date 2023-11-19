class BoxesController < ApplicationController

  def index
    @pagy, @boxes = pagy(Box.all.order(id: :desc))
  end

end
