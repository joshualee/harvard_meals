class Meal < BaseModel
  require "net/http"
  
  attr_accessor :date, :type

  def dishes
    uri = URI("#{BASE_URL}/menus?meal=#{type}&sdt=#{date}&output=json")
    response = Net::HTTP.get_response(uri)
    raise ActiveRecord::RecordNotFound unless response.is_a?(Net::HTTPSuccess)
    dishes = Dish.collection_from_json(response.body)
    return dishes
  end
end
