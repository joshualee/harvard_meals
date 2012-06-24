class Meal
  has_many :dishes
  attr_accessor :date #YYYY-MM-DD
  attr_accessor :type #breakfast, lunch, brunch, dinner
end

class Dish
  belongs_to :meal
  has_many :facts
  attr_accessor :category, :recipe, :name, :portion, :unit
  attr_accessor :vegetarian, 
end

class Fact
  attr_accessor :type, :amount, :percent
end

