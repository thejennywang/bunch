class MidpointCalculator

	def self.find_by(metric, points)
		latitude = _average_of(:lat, points)
		longitude = _average_of(:lng, points)
		Coordinate.new(latitude, longitude)
	end

end

def _average_of(attribute, array)
	array.map(&attribute).inject(&:+) / array.length
end