require 'calculators/midpoint_calculator'

describe MidpointCalculator do

	let(:coord_1)	{ double Coordinate, lat: 50, lng: 70 }
	let(:coord_2) { double Coordinate, lat: 20, lng: 10 }
	let(:coords)	{ [coord_1, coord_2] 									}

	it 'should return a coordinate object' do
		expect(MidpointCalculator.midpoint_by(:distance, coords)).to be_an_instance_of(Coordinate)
	end
	
	context 'Distance - two coordinate case' do

		it 'should return coordinates for the equidistant point given 2 other coordinates' do
			expect(MidpointCalculator.midpoint_by(:distance, coords).lat).to eq 35
			expect(MidpointCalculator.midpoint_by(:distance, coords).lng).to eq 40
		end

		it 'should return coordinates for the middle of n coordinates' do
			coord_3 = double Coordinate, lat: 50, lng: 100
			coords << coord_3
			expect(MidpointCalculator.midpoint_by(:distance, coords).lat).to eq 40
			expect(MidpointCalculator.midpoint_by(:distance, coords).lng).to eq 60
		end

	end

	context 'Drive time along a stright line - two coordinate case' do

		let(:london_coord_1) 			{ double Coordinate, lat: 51.507351, lng: -0.127758 }
		let(:london_coord_2) 			{ double Coordinate, lat: 51.551795, lng: -0.064643 }
		let(:london_coords)			  { [london_coord_1, london_coord_2]							    }	

		it 'should return coordinates for the point of equal drive time between 2 other coordinates' do
			result = MidpointCalculator.midpoint_by(:drive_time, london_coords)
			time_1 = _drive_times(result, london_coord_1).first
			time_2 = _drive_times(result, london_coord_2).last
			expect(time_1).to be_within(300).of time_2
		end 
		
	end

	context 'Drive time using a grid - two coordinate case' do

			let(:coord_1)			{ double Coordinate, lat: 0, lng: 0 										}
			let(:coord_2) 		{ double Coordinate, lat: 30, lng: 40 									}
			let(:coords)			{ [coord_1, coord_2] 																		}
		
		context 'selecting initial guesses' do

			let (:locations) 	{ MidpointCalculator.locations_equidistant_from(coords) }

			xit 'returns the angle betweeen two coordinates' do
				expect(MidpointCalculator._angle_between(coords)).to be_within(0.1).of -0.64
			end 

			it 'returns an array of coordinates which are equidistant between two start points A and B' do
				locations.each do |location|
				distance1 = _distance_between([coord_1,location])
				distance2 = _distance_between([coord_2,location])
				expect(distance1-distance2).to be_within(0.1).of 0
				end
				puts locations.inspect
			end

			it 'returns an array of coordinates spaced over a distance A-B' do
				midpoint = MidpointCalculator.midpoint_by(:distance, coords)
				locations_extremes = [locations.first, locations.last]
				extremes_midpoint = MidpointCalculator.midpoint_by_distance(locations_extremes)

				expect(_distance_between([midpoint,extremes_midpoint])).to be_within(0.01).of 0
				expect(_distance_between([locations.first,locations.last])).to be_within(0.01).of 50
			end

		end

		context 'finding minimum drive times' do

			let (:location1)  { double Coordinate, lat: -5.0, lng: 35.0 	}
			let (:location2)  { double Coordinate, lat: 15, lng: 20 			}
			let (:location3)  { double Coordinate, lat: 35.0, lng: 5.0 	 	}
			let (:locations) 	{ [location1,location2,location3] 					}	

			it 'finds the two drive times to the location guess array' do
				expect(JourneyTimeCalculator).to receive(:drive_times_between).exactly(locations.length).times
				MidpointCalculator.get_travel_times_for(coords,locations)
			end

			it 'selects the location with the minimum combined driving time' do
				allow(JourneyTimeCalculator).to receive(:drive_times_between).and_return([20,25],[10,15],[25,5])
				expect(MidpointCalculator.quickest_location(coords,locations)).to eq location2
			end

		end

	end

	def _drive_times(origin, destination)
		JourneyTimeCalculator.drive_times_between([origin], destination)
	end
 


end