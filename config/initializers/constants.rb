BASE_URL = "http://food.cs50.net/api/1.3/"

class BaseModel
  def initialize(attributes = {})
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
end