class VenueDataRetriever

  NUMBER_OF_VENUES = 50
  NUMBER_TO_SELECT = 3
  RADIUS = 250

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

  def self.request_foursquare_data(midpoint, options, multiplier=1)
    data = fetch_json_from(build_foursquare_url(midpoint, options, multiplier))
    if venue_count(data) < 20
      data = request_foursquare_data(midpoint, options, multiplier + 1)
    end
    data
  end

  private

  def self.build_foursquare_url(midpoint, options, multiplier)
    keys = 'client_id=' + FOURSQUARE_ID + '&client_secret=' + FOURSQUARE_SECRET
    location = '&v=20130815&ll=' + midpoint.lat.to_s + ',' + midpoint.lng.to_s
    BASE_URI + keys + location + '&radius=' + (RADIUS * multiplier).to_s + '&limit=' + NUMBER_OF_VENUES.to_s + '&section=' + options
  end

  def self.fetch_json_from(url)
    data = Net::HTTP.get(URI.parse(URI.encode(url)))
    JSON.parse(data)
  end

end