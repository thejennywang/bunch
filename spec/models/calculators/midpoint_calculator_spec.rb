require 'calculators/midpoint_calculator'

describe MidpointCalculator do
	
	context 'distance - two point case' do

		let(:point_1)	{ double Coordinate, lat: 50, lng: 80 }
		let(:point_2) { double Coordinate, lat: 20, lng: 10 }
		let(:points)	{ [point_1, point_2] }

		it 'should return a coordinate object' do
			expect(MidpointCalculator.find_by(:distance, points)).to be_an_instance_of(Coordinate)
		end

		it 'should return coordinates for the equidistant point given 2 other points' do
			expect(MidpointCalculator.find_by(:distance, points).lat).to eq 35
			expect(MidpointCalculator.find_by(:distance, points).lng).to eq 45
		end

	end

end