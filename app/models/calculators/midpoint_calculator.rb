include Math

class MidpointCalculator

	TIME_THRESHOLD = 300
	DEFAULT_VECTOR_STEP = 0.2
	DEFAULT_VECTOR_RANGE = (-1..1)

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
			times = JourneyTimeCalculator.drive_times_between(coordinates, [midpoint_guess])
			return midpoint_guess if _time_spread(times) < TIME_THRESHOLD
			midpoint_guess = _guess_for([midpoint_guess, _furthest_coordinate(coordinates, times)])
		end
	end

	def self._guess_for(coordinates)
		self.midpoint_by(:distance, coordinates)
	end

	def self.locations_equidistant_from(coordinates)
		relative_vector.map do |segment|
			new_location_equidistant_from(coordinates, segment * _max_distance(coordinates))
		end
	end

	def self.new_location_equidistant_from(coordinates, distance_from_midpoint)
		midpoint = midpoint_by(:distance, coordinates)
		delta_lat, delta_lng = _perpendicular_vector(coordinates, distance_from_midpoint)
		Coordinate.new(midpoint.lat + delta_lat, midpoint.lng + delta_lng)
	end

	def self.relative_vector
		DEFAULT_VECTOR_RANGE.step(DEFAULT_VECTOR_STEP).to_a
	end

	def self.quickest_location(origins, locations)
		times = JourneyTimeCalculator.drive_times_between(origins, locations)
		times.index(times.min)
	end

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

def _change_in(attribute, array)
	array.map(&attribute).inject(&:-)
end

def _distance_between(coordinates)
	sqrt((_change_in(:lat,coordinates)**2 + _change_in(:lng,coordinates)**2))
end

def _max_distance(coordinates)
	_distance_between(coordinates)/2.0
end

def _angle_between(coordinates)
	atan(_change_in(:lng,coordinates)/_change_in(:lat,coordinates).to_f)
end

def _perpendicular_vector(coordinates, length)
	theta = _angle_between(coordinates)
	[length*sin(-theta),length*cos(-theta)]
end


