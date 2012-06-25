class MealsController < ApplicationController
  require 'date'

  def show
    @date = "2011-03-21" || params[:date] || Date.today.to_s
    @type = "breakfast" || params[:type] || current_meal_type
    @meal = Meal.new(type: @type, date: @date)
    @dishes = @meal.dishes
    @grouped_dishes = @dishes.group_by { |dish| dish.category }
  end
  
  private
  
  def current_meal_type
    now = DateTime.now
    if now.hour < 10
      return "breakfast"
    elsif now.hour < 15
      return "lunch"
    else 
      return "dinner"
    end
  end
end
