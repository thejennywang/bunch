require 'net/http'

class JourneyTimeCalculator

	API_KEY = Rails.application.secrets.google_api_key
	BASE_URI = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
	BASE_OPTIONS = "&mode=driving&key=#{API_KEY}"

	def self.times_between(origins, destinations, mode)
		case mode
			when :drive
				self.drive_times_between(origins, destinations)
		end
	end

	def self.drive_times_between(origins, destinations)
		json_data = fetch_json_from(build_url(origins, destinations))
		return unless json_data
		retrieve_durations_from(json_data)
	end

	private 

	def self.fetch_json_from(url)
		data = Net::HTTP.get(URI.parse(URI.encode(url)))
		JSON.parse(data)
	end

	def self.build_url(origins, destinations)
		BASE_URI + build_origins_string(origins) +
		 build_destinations_string(destinations) + BASE_OPTIONS
	end

	def self.retrieve_durations_from(json_data)
		result = []
		json_data['rows'].each { |element| result << element['elements'].map { |journey| journey['duration']['value'] } }
		result
	end

	def self.build_origins_string(origins)
		string = "origins="
		origins.each { |origin| string << "#{origin.lat},#{origin.lng}\|" }
		string.chomp("\|")
	end

	def self.build_destinations_string(destinations)
		string = "&destinations="
		destinations.each { |destination| string << "#{destination.lat},#{destination.lng}\|" }
		string.chomp("\|")
	end

	def self.cumulative_times_between(origins, destinations, mode)
		individual_times = times_between(origins, destinations, mode)
		individual_times.map{ |times| times.inject(&:+) }
	end

	def self.max_time_between(coords, mode)
		origins, destinations = _split_in_half(coords)
		times_between(origins,destinations, mode).flatten.max
	end

end

def _split_in_half(array)
	array.each_slice( (array.size/2.0).round ).to_a
end


