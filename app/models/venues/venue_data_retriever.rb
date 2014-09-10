class VenueDataRetriever

  NUMBER_OF_VENUES = 50
  NUMBER_TO_SELECT = 3
  DEFAULT_RADIUS = 250
  RADIUS_INCREMENT = 250
  MIN_NUMBER_OF_VENUES = 20

  FOURSQUARE_ID = Rails.application.secrets.foursquare_client_id
  FOURSQUARE_SECRET = Rails.application.secrets.foursquare_client_secret

  BASE_URI = 'https://api.foursquare.com/v2/venues/explore?'

  def self.create_venues(data)
    (0...venue_count(data)).map do |element|
      Venue.new(data['response']['groups'][0]['items'][element]["venue"])
    end
  end

  def self.venue_count(data)
    data['response']['groups'][0]['items'].length
  end

  def self.sort_by_rating(venues)
    venues.sort_by{ |venue| venue.rating }.reverse
  end

  def self.select_venues(data)
    sort_by_rating(create_venues(data)).slice(0, NUMBER_TO_SELECT)
  end

  def self.request_foursquare_data(midpoint, options, radius=DEFAULT_RADIUS)
    data = call_foursquare_api(midpoint, options, radius)
    return data, radius unless venue_count(data) < MIN_NUMBER_OF_VENUES 
    data, radius = request_foursquare_data(midpoint, options, radius + RADIUS_INCREMENT)
  end

  private

  def self.call_foursquare_api(midpoint, options, radius)
    fetch_json_from(build_foursquare_url(midpoint, options, radius))
  end

  def self.build_foursquare_url(midpoint, options, radius)
    keys = 'client_id=' + FOURSQUARE_ID + '&client_secret=' + FOURSQUARE_SECRET
    location = '&v=20130815&ll=' + midpoint.lat.to_s + ',' + midpoint.lng.to_s
    BASE_URI + keys + location + '&radius=' + radius.to_s + '&limit=' + NUMBER_OF_VENUES.to_s + '&section=' + options
  end

  def self.fetch_json_from(url)
    data = Net::HTTP.get(URI.parse(URI.encode(url)))
    JSON.parse(data)
  end

end