module CalculatorTools

	include Math

	def time_spread(times)
		times[0].first - times[1].first
	end

	def furthest_coordinate(coordinates, times)
		coordinates[max_element_index(times)]
	end

	def average_of(attribute, array)
		array.map(&attribute).inject(&:+) / array.length
	end

	def max_element_index(array)
		array.index(array.max)
	end

	def min_element_index(array)
		array.index(array.min)
	end

	def change_in(attribute, array)
		array.map(&attribute).inject(&:-)
	end

	def distance_between(coordinates)
		sqrt((change_in(:lat, coordinates)**2 + change_in(:lng, coordinates)**2))
	end

	def max_distance(coordinates)
		distance_between(coordinates) / 2.0
	end

	def angle_between(coordinates)
		atan(change_in(:lng, coordinates) / change_in(:lat, coordinates).to_f)
	end

	def perpendicular_vector(coordinates, length)
		theta = angle_between(coordinates)
		[ length * sin(-theta), length * cos(-theta) ]
	end

	def split_unless_single(array)
		return array if _single?(array)
		split_in_half(array)
	end

	def split_in_half(array)
		array.each_slice( (array.size/2.0).round ).to_a
	end

	def single?(array)
		array.length == 1
	end

end