class MidpointCalculator

	TIME_THRESHOLD = 300

	def self.midpoint_by(metric, coordinates)
		case metric
			when :distance 
				self.midpoint_by_distance(coordinates)
			when :drive_time
				self.midpoint_by_drive_time(coordinates)
		end
	end

	def self.midpoint_by_distance(coordinates)
		latitude = _average_of(:lat, coordinates)
		longitude = _average_of(:lng, coordinates)
		Coordinate.new(latitude, longitude)
	end

	def self.midpoint_by_drive_time(coordinates)
		midpoint_guess = _guess_for(coordinates)
		loop do
			times = JourneyTimeCalculator.drive_time_between(coordinates, midpoint_guess)
			return midpoint_guess if _time_spread(times) < TIME_THRESHOLD
			midpoint_guess = _guess_for([midpoint_guess, _furthest_coordinate(coordinates, times)])
		end
	end

end

def _guess_for(coordinates)
	MidpointCalculator.midpoint_by_distance(coordinates)
end

def _time_spread(times)
	times[0] - times[1]
end

def _furthest_coordinate(coordinates, times)
	coordinates[_max_element_index(times)]
end

def _average_of(attribute, array)
	array.map(&attribute).inject(&:+) / array.length
end

def _max_element_index(array)
	array.index(array.max)
end