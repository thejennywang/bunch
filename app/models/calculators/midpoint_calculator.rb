class MidpointCalculator

	TIME_THRESHOLD = 300
	GRID_SPACING = [-1,-0.8,-0.6,-0.4,-0.2,0,0.2,0.4,0.6,0.8,1]

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
			times = JourneyTimeCalculator.drive_times_between(coordinates, midpoint_guess)
			return midpoint_guess if _time_spread(times) < TIME_THRESHOLD
			midpoint_guess = _guess_for([midpoint_guess, _furthest_coordinate(coordinates, times)])
		end
	end

	def self._guess_for(coordinates)
		self.midpoint_by_distance(coordinates)
	end

	def self.angle_between(coordinates)
		change_in_lat = _change_in(:lat, coordinates)
		change_in_lng = _change_in(:lng, coordinates)
		Math.atan(-change_in_lat/change_in_lng.to_f)
	end

	def change_in_long(coordinates)
		coordinates[0].lng-coordinates[1].lng
	end

	def change_in_lat(coordinates)
		coordinates[0].lat-coordinates[1].lat
	end

	def self.locations_equidistant_from(coordinates)
			midpoint = self.midpoint_by_distance(coordinates)
			length = _distance_between(coordinates)/2.0
			x = length*Math.cos(angle_between(coordinates))
			y = length*Math.sin(angle_between(coordinates))
				GRID_SPACING.map do |index|
					(Coordinate.new(midpoint.lat+x*index, midpoint.lng+y*index))
				end
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

def _change_in(attribute, array)
	array.map(&attribute).inject(&:-)
end

def _max_element_index(array)
	array.index(array.max)
end

def _distance_between(coordinates)
		x_distance = coordinates[0].lat-coordinates[1].lat
		y_distance = coordinates[0].lng-coordinates[1].lng
		Math.sqrt((x_distance**2 + y_distance**2))
end



