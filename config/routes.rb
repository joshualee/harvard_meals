HarvardMeals::Application.routes.draw do

  root :to => 'meals#show'
  get "meals" => 'meals#show'
  get "meals/:date" => 'meals#show'
  get "meals/:date/:type" => 'meals#show'
  
end
