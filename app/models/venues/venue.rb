class Venue

  DEFAULT = 'N/A'
    
  attr_reader :name, :full_address, :lat, :lng, :category, :price_tier, :rating, :id, :icon

  def initialize venue_information 
    @name = venue_information["name"]
    @full_address = venue_information["location"]["formattedAddress"]
    @lat = venue_information["location"]["lat"]
    @lng = venue_information["location"]["lng"] 
    @category = venue_information.fetch("categories", [{}])[0].fetch("name", DEFAULT) 
    @price_tier = venue_information.fetch("price", {}).fetch("tier", DEFAULT)
    @rating = venue_information.fetch("rating", DEFAULT)
    @id = venue_information["id"]
    @icon = venue_information.fetch("categories", [{}])[0].fetch("icon", DEFAULT).values.join("bg_44")
  end
end