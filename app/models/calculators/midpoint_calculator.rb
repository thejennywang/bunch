class MidpointCalculator

	TIME_THRESHOLD = 300

	def self.find_by(metric, coordinates)
		case metric
			when :distance 
				self.find_by_distance(coordinates)
			when :drive_time
				self.find_by_drive_time(coordinates)
		end
	end

	def self.find_by_distance(coordinates)
		latitude = _average_of(:lat, coordinates)
		longitude = _average_of(:lng, coordinates)
		Coordinate.new(latitude, longitude)
	end

	def self.find_by_drive_time(coordinates)
		midpoint_guess = self.find_by_distance(coordinates)
		loop do
			times = JourneyTimeCalculator.drive_time_between(coordinates, midpoint_guess)
			break if (times[0] - times[1]) < TIME_THRESHOLD
			furthest_coordinate = coordinates[_max_element_index(times)]
			midpoint_guess = self.find_by_distance([midpoint_guess, furthest_coordinate])
		end
		midpoint_guess
	end

end

def _average_of(attribute, array)
	array.map(&attribute).inject(&:+) / array.length
end

def _max_element_index(array)
	array.index(array.max)
end