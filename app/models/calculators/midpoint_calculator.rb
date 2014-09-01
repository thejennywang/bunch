class MidpointCalculator

	def self.find_by(metric, coordinates)
		case metric
			when :distance 
				self.find_by_distance(coordinates)
		end
	end

	def self.find_by_distance(coordinates)
		latitude = _average_of(:lat, coordinates)
		longitude = _average_of(:lng, coordinates)
		Coordinate.new(latitude, longitude)
	end

end

def _average_of(attribute, array)
	array.map(&attribute).inject(&:+) / array.length
end