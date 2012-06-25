class Fact < BaseModel
  attr_accessor :type, :amount, :percent
  
  def self.collection_from_json(json)
    collection = []
    JSON.parse(json).each do |fact|
      collection << new(:type => fact["fact"],
                        :amount => fact["amount"],
                        :percent => fact["percent"]
                       )
    end
    return collection
  end
end
