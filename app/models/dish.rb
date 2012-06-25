class Dish < BaseModel

  attr_accessor :category, :recipe, :name, :portion, :unit
  attr_accessor :ingredients, :vegetarian, :vegan, :local, :organic, :mollie_katzen

  def facts 
    uri = URI("#{BASE_URL}/facts?recipe=#{recipe}&portion=#{portion}&output=json")
    response = Net::HTTP.get_response(uri)
    raise ActiveRecord::RecordNotFound unless response.is_a?(Net::HTTPSuccess)
    facts = Fact.collection_from_json(response.body)
    return facts
  end
  
  def self.collection_from_json(json)
    parsed_json = JSON.parse(json)
    ids = parsed_json.map { |dish| dish["recipe"] }
    recipes = get_recipes_by_ids(ids)
    collection = []
    parsed_json.each do |dish|
      recipe = recipes[dish["recipe"]]
      collection << new(:category => dish["category"], 
                        :recipe => dish["recipe"],
                        :name => dish["name"],
                        :portion => dish["portion"],
                        :unit => dish["unit"],
                        :ingredients => recipe["ingredients"],
                        :vegetarian => recipe["VEGETARIAN"],
                        :vegan => recipe["VEGAN"],
                        :mollie_katzen => recipe["MOLLIE KATZEN"],
                        :local => recipe["LOCAL"],
                        :organic => recipe["ORGANIC"]
                       )
    end
    return collection
  end
  
  [:vegetarian, :vegan, :local, :organic, :mollie_katzen].each do |method|
    define_method(method) do
      var = instance_variable_get("@#{method}")
      var && var.downcase != "false"
    end
  end
  
  private
  
  def self.get_recipes_by_ids(ids)
    id_list = ids.join(",")
    uri = URI("#{BASE_URL}/recipes?id=#{id_list}&output=json")
    response = Net::HTTP.get_response(uri)
    raise ActiveRecord::RecordNotFound unless response.is_a?(Net::HTTPSuccess)
    recipes = {}
    JSON.parse(response.body).each do |recipe|
      recipes[recipe["id"]] = recipe
    end
    return recipes
  end
end
