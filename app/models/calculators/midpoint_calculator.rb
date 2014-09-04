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



	def self.locations_equidistant_from(coordinates)
			max_distance = _distance_between(coordinates)/2.0
				GRID_SPACING.map do |spacing|
					new_location_equidistant_from(coordinates,spacing*max_distance)
				end
	end

	def self.new_location_equidistant_from(coordinates,distance_from_midpoint)
		midpoint = self.midpoint_by_distance(coordinates)
		theta = _angle_between(coordinates)
		delta_lat = distance_from_midpoint*Math.sin(-theta)
		delta_lng = distance_from_midpoint*Math.cos(-theta)
		Coordinate.new(midpoint.lat+delta_lat, midpoint.lng+delta_lng)
	end

	def self.get_travel_times_for(origins,locations)
		locations.map do |location|
			JourneyTimeCalculator.drive_times_between(origins,locations)
		end
	end

	def self.quickest_location(origins,locations)
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
	Math.sqrt((_change_in(:lat,coordinates)**2 + _change_in(:lng,coordinates)**2))
end

def _angle_between(coordinates)
	Math.atan(_change_in(:lng,coordinates)/_change_in(:lat,coordinates).to_f)
end




