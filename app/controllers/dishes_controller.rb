class DishesController < ApplicationController

  def show
    @dish = Dish.new(:recipe => params[:recipe], :name => params[:name], :portion => params[:portion], :ingredients => params[:ingredients])
    # if request.xhr?
      render :partial => "meals/dish_info", :locals => { :dish => @dish }
    # else
      # raise "Not yet implemented"
    # end
  end
end
