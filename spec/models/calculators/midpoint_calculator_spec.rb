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

	context 'Time - two coordinate case' do

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

	def _drive_times(origin, destination)
		JourneyTimeCalculator.drive_times_between([origin], destination)
	end

end