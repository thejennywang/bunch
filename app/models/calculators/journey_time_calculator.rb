require 'net/http'

class JourneyTimeCalculator

	API_KEY = Rails.application.secrets.google_api_key
	BASE_URI = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
	BASE_OPTIONS = "&mode=driving&key=#{API_KEY}"

	def self.drive_times_between(origins, destination)
		json_data = fetch_json_from(build_url(origins, destination))
		_retrieve_durations_from(json_data)
	end

	def self.fetch_json_from(url)
		data = Net::HTTP.get(URI.parse(URI.encode(url)))
		JSON.parse(data)
	end

	def self.build_url(origins, destination)
		BASE_URI + _build_origins_string(origins) +
		"&destinations=#{destination.lat},#{destination.lng}" + BASE_OPTIONS
	end

end

def _retrieve_durations_from(json_data)
	return unless json_data
	json_data['rows'].map { |row| row['elements'][0]['duration']['value'] }
end

def _build_origins_string(origins)
	string = "origins="
	origins.each { |origin| string << "#{origin.lat},#{origin.lng}\|" }
	string.chomp("\|")
end

