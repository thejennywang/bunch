class JourneyTimeCalculator

	extend CalculatorTools

	def self.times_between(origins, destinations, mode)
		case mode
			when :drive
				self.drive_times_between(origins, destinations)
		end
	end

	def self.drive_times_between(origins, destinations)
		JourneyTimeDataRetriever.retrieve_data_for(origins, destinations)
	end

	def self.cumulative_times_between(origins, destinations, mode)
		individual_times = times_between(origins, destinations, mode)
		individual_times.map{ |times| times.inject(&:+) }
	end

	def self.max_time_between(coords, mode)
		unique_journeys(coords).map{ |origin, dest| times_between(origin, dest, mode) }.flatten.max
	end

	def self.unique_journeys(locations, journeys = [])
		journey = split_unless_single(locations)
		journeys << journey
		journey.each do |leg|
			return journeys if single?(leg)
			unique_journeys(leg, journeys)
		end
		journeys
	end

	# ------- Potential refactore of unique journeys------
	# def self.unique_journeys(location)
	# 	journeys = split_unless_single(location)
	# 	[journeys] + legs_for(journeys)
	# end

	# def self.legs_for(journeys)
	# 	return [journeys] unless journeys.respond_to?(:map)
	# 	journeys.map {|j| legs_for(j) } 
	# end

end


