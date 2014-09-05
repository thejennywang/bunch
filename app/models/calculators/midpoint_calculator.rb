require_relative 'calculator_tools'

class MidpointCalculator

	TIME_THRESHOLD = 300
	DEFAULT_VECTOR_STEP = 0.2
	DEFAULT_VECTOR_RANGE = (-1..1)

	extend CalculatorTools

	def self.midpoint_by(metric, coordinates)
		case metric
			when :distance 
				self.midpoint_by_distance(coordinates)
			when :drive_time
				return self.simple_midpoint_by_time(coordinates) if simple?(coordinates)
				complex_midpoint_by_time(coordinates)
		end
	end

	def self.midpoint_by_distance(coordinates)
		latitude = average_of(:lat, coordinates)
		longitude = average_of(:lng, coordinates)
		Coordinate.new(latitude, longitude)
	end

	def self.complex_midpoint_by_time(coordinates, mode=:drive)
		pairs = coordinates.combination(2).to_a
		pair_midpoints = _midpoint_array(pairs)
		max_midpoint_separation = JourneyTimeCalculator.max_time_between(pair_midpoints, mode)
		return midpoint_by_distance(pair_midpoints) if max_midpoint_separation < TIME_THRESHOLD
		complex_midpoint_by_time(pair_midpoints, mode)
	end

	def self.simple_midpoint_by_time(coordinates, mode=:drive)
		midpoint_guess = guess_for(coordinates, mode)
		loop do
			times = JourneyTimeCalculator.times_between(coordinates, [midpoint_guess], mode)
			return midpoint_guess if time_spread(times) < TIME_THRESHOLD
			midpoint_guess = guess_for(midpoint_guess, furthest_coordinate(coordinates, times), mode)
		end
	end

	def self.guess_for(coordinates, mode)
		locations = locations_equidistant_from(coordinates)
		quickest_location(coordinates, locations, mode)
	end

	def self.locations_equidistant_from(coordinates)
		relative_vector.map do |segment|
			new_location_equidistant_from(coordinates, segment * max_distance(coordinates))
		end
	end

	def self.new_location_equidistant_from(coordinates, distance_from_midpoint)
		midpoint = midpoint_by(:distance, coordinates)
		delta_lat, delta_lng = perpendicular_vector(coordinates, distance_from_midpoint)
		Coordinate.new(midpoint.lat + delta_lat, midpoint.lng + delta_lng)
	end

	def self.relative_vector
		DEFAULT_VECTOR_RANGE.step(DEFAULT_VECTOR_STEP).to_a
	end

	def self.quickest_location(origins, locations, mode)
		cumulative_times = JourneyTimeCalculator.cumulative_times_between(origins, locations, mode)
		locations[min_element_index(cumulative_times)]
	end

	def self.simple?(coordinates)
		coordinates.count == 2
	end

end

def _midpoint_array(pairs)
	pairs.map{ |pair| simple_midpoint_by_time(pair) }
end

def _time_between(pt1, pt2, mode)
	JourneyTimeCalculator.times_between([pt1], [pt2], mode).flatten(1).first
end



