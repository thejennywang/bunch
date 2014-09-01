require 'calculators/midpoint_calculator'

describe MidpointCalculator do
	
	context 'distance - two coordinate case' do

		let(:coord_1)	{ double Coordinate, lat: 50, lng: 70 }
		let(:coord_2) { double Coordinate, lat: 20, lng: 10 }
		let(:coords)	{ [coord_1, coord_2] 									}

		it 'should return a coordinate object' do
			expect(MidpointCalculator.find_by(:distance, coords)).to be_an_instance_of(Coordinate)
		end

		it 'should return coordinates for the equidistant point given 2 other coordinates' do
			expect(MidpointCalculator.find_by(:distance, coords).lat).to eq 35
			expect(MidpointCalculator.find_by(:distance, coords).lng).to eq 40
		end

		it 'should return coordinates for the middle of n coordinates' do
			coord_3 = double Coordinate, lat: 50, lng: 100
			coords << coord_3
			expect(MidpointCalculator.find_by(:distance, coords).lat).to eq 40
			expect(MidpointCalculator.find_by(:distance, coords).lng).to eq 60
		end

	end

end