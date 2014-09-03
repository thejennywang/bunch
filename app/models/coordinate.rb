class Coordinate

	attr_accessor :lat, :lng

	def initialize(latitude, longitude)
		@lat = latitude
		@lng = longitude
	end

	def self.create_from(address)
		new(address.lat, address.lng)
	end

end