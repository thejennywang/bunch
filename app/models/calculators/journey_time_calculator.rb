require 'net/http'

class JourneyTimeCalculator

	API_KEY = Rails.application.secrets.google_api_key
	BASE_URI = 'https://maps.googleapis.com/maps/api/distancematrix/json?'
	BASE_OPTIONS = "&mode=driving&key=#{API_KEY}"

	def self.drive_time_between(origin, destination)
		fetch_data(build_url(origin, destination))
		25
	end

	def self.fetch_data(url)
		data = Net::HTTP.get(URI.parse(url))
		JSON.parse(data)
	end

	def self.build_url(origin, destination)
		BASE_URI + "origins=#{origin.lat},#{origin.lng}"\
		"&destinations=#{destination.lat},#{destination.lng}" + BASE_OPTIONS
	end

end


