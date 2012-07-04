HarvardMeals::Application.routes.draw do

  root :to => "meals#show"
  get "meals" => "meals#show", :as => :meal
  get "meals/:date" => "meals#show", :as => :meal_date
  get "meals/:date/:type" => "meals#show", :as => :meal_date_type
  get "dishes/:recipe" => "dishes#show", :as => :dish_recipe
  
end
