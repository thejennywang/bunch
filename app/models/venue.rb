class Venue

  FOURSQUARE_ID = Rails.application.secrets.foursquare_client_id
  FOURSQUARE_SECRET = Rails.application.secrets.foursquare_client_secret

attr_reader :name, :address, :lat, :lng

  def initialize venue_information 
    @name = venue_information["name"]
    @address = venue_information["location"]["formattedAddress"]
    @lat = venue_information["location"]["lat"]
    @lng = venue_information["location"]["lat"]  
  end

  def self.select_venues(number, data)
    data['response']['groups'][0]['items'].take(number)
  end

  def self.request_foursquare_data(midpoint,options)
    fetch_json_from(build_foursqaure_url(midpoint,options))
  end

  def self.build_foursqaure_url(midpoint,options)
    base_url = 'https://api.foursquare.com/v2/venues/explore?'
    keys = 'client_id=' + FOURSQUARE_ID + '&client_secret=' + FOURSQUARE_SECRET
    location = '&v=20130815&ll=' + midpoint.lat.to_s + ',' + midpoint.lng.to_s
    options = '&radius=1000' + '&section=' + options
    base_url + keys + location + options
  end

  def self.fetch_json_from(url)
    data = Net::HTTP.get(URI.parse(URI.encode(url)))
    JSON.parse(data)
  end
  
end