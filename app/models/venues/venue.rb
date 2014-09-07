class Venue


attr_reader :name, :address

  def initialize venue_information 
    @name = venue_information["name"]
    @address = venue_information["location"]["formattedAddress"]
    # @lat = venue_information["location"]["lat"]
    # @lng = venue_information["location"]["lat"]  
  end
  
end