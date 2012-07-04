class MealsController < ApplicationController
  require 'date'

  def show
    @date = params[:date].to_date || Date.today
    @type = params[:type] || current_meal_type
    
    if @date.sunday? && (["breakfast", "lunch"].include?(@type))
      @type = "brunch"
    end
    
    @meal = Meal.new(type: @type, date: @date)
    @dishes = @meal.dishes
    @grouped_dishes = @dishes.group_by { |dish| dish.category }
    @no_dishes = @grouped_dishes.empty?
    @current_week = @date.at_beginning_of_week
    @failed_to_load = false
    
  rescue
    @failed_to_load = true
  ensure
    @weeks ||= four_weeks_from_today
    @date ||= Date.today
    @type ||= params[:type] || current_meal_type
    @current_week ||= Date.today.at_beginning_of_week
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
  
  def four_weeks_from_today
    this_week = Date.today.prev_week.next_week
    second_week = this_week.next_week
    third_week = second_week.next_week 
    fourth_week = third_week.next_week
    [this_week, second_week, third_week, fourth_week]
  end
end
