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
		times = []
		unique_journeys(coords).each do |origin_dest_pair|
			times << times_between(origin_dest_pair.first, origin_dest_pair.last, mode)
		end
		times.flatten.max
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

end


