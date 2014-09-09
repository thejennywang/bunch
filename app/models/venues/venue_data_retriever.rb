class VenueDataRetriever

  NUMBER_OF_VENUES = 50

  FOURSQUARE_ID = Rails.application.secrets.foursquare_client_id
  FOURSQUARE_SECRET = Rails.application.secrets.foursquare_client_secret

  BASE_URI = 'https://api.foursquare.com/v2/venues/explore?'


  def self.create_venues(data)
    venue_count = data['response']['groups'][0]['items'].length
    (0...venue_count).map do |element|
      Venue.new(data['response']['groups'][0]['items'][element]["venue"])
    end
  end

  def self.sort_by_rating(venues)
    venues.sort_by{ |venue| venue.rating }.reverse
  end

  def self.select_three_venues(data)
    puts create_venues(data).inspect
    sort_by_rating(create_venues(data)).slice(0, 3)
  end

  def self.request_foursquare_data(midpoint, options)
    puts build_foursquare_url(midpoint, options)
    fetch_json_from(build_foursquare_url(midpoint, options))
  end

  private

  def self.build_foursquare_url(midpoint, options)
    keys = 'client_id=' + FOURSQUARE_ID + '&client_secret=' + FOURSQUARE_SECRET
    location = '&v=20130815&ll=' + midpoint.lat.to_s + ',' + midpoint.lng.to_s
    BASE_URI + keys + location + '&radius=5000&limit=' + NUMBER_OF_VENUES.to_s + '&section=' + options
  end

  def self.fetch_json_from(url)
    data = Net::HTTP.get(URI.parse(URI.encode(url)))
    JSON.parse(data)
  end

end