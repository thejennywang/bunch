require 'net/http'

class JourneyTimeCalculator

	API_KEY = Rails.application.secrets.google_api_key
	BASE_URI = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
	BASE_OPTIONS = "&mode=driving&key=#{API_KEY}"

	def self.drive_time_between(origin, destination)
		json_data = fetch_json_from(build_url(origin, destination))
		retrieve_duration_from(json_data)
	end

	def self.fetch_json_from(url)
		data = Net::HTTP.get(URI.parse(url))
		JSON.parse(data)
	end

	def self.build_url(origin, destination)
		BASE_URI + "origins=#{origin.lat},#{origin.lng}"\
		"&destinations=#{destination.lat},#{destination.lng}" + BASE_OPTIONS
	end

end

def retrieve_duration_from(json_data)
	return unless json_data
	json_data['rows'][0]['elements'][0]['duration']['value']
end


