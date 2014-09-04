require 'net/http'

class JourneyTimeCalculator

	API_KEY = Rails.application.secrets.google_api_key
	BASE_URI = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
	BASE_OPTIONS = "&mode=driving&key=#{API_KEY}"

	def self.drive_times_between(origins, destinations)
		json_data = fetch_json_from(build_url(origins, destinations))
		_retrieve_durations_from(json_data)
	end

	def self.fetch_json_from(url)
		data = Net::HTTP.get(URI.parse(URI.encode(url)))
		JSON.parse(data)
	end

	def self.build_url(origins, destinations)
		BASE_URI + _build_origins_string(origins) +
		 _build_destinations_string(destinations) + BASE_OPTIONS
	end

end

def _retrieve_durations_from(json_data)
	return unless json_data
	result = []
	json_data['rows'].each { |element| result << element['elements'].map { |journey| journey['duration']['value'] } }
	result.flatten
end

def _build_origins_string(origins)
	string = "origins="
	origins.each { |origin| string << "#{origin.lat},#{origin.lng}\|" }
	string.chomp("\|")
end

def _build_destinations_string(destinations)
	string = "&destinations="
	destinations.each { |destination| string << "#{destination.lat},#{destination.lng}\|" }
	string.chomp("\|")
end
