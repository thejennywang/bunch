class Venue
  attr_reader :name, :full_address, :lat, :lng, :category, :price_tier, :rating, :id

  def initialize venue_information 
    @name = venue_information["name"]
    @full_address = venue_information["location"]["formattedAddress"]
    @lat = venue_information["location"]["lat"]
    @lng = venue_information["location"]["lng"] 
    @category = venue_information["categories"][0]["name"] 
    @price_tier = venue_information["price"]["tier"]
    @rating = venue_information["rating"]
    @id = venue_information["id"]
  end
  
end