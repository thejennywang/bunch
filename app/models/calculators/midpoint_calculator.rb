class MidpointCalculator

	def self.find_by(metric, points)
		latitude = _average_of(:lat, points)
		longitude = _average_of(:lng, points)
		Coordinate.new(latitude, longitude)
	end

	private

	def self._average_of(attribute, array)
		array.map(&attribute).inject(&:+) / array.length
	end

end