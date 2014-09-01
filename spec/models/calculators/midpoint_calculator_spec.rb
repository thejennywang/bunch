require 'calculators/midpoint_calculator'

describe MidpointCalculator do
	
	context 'distance - two point case' do

		it 'should return coordinates for the equidistant point given 2 other points' do
			point_1 = { lat: 50, lng: 50 }
			point_2 = { lat: 20, lng: 10 }
			points = [point_1, point_2]
			expect(MidpointCalculator.find_by(:distance, points)).to eq({ lat: 35, lng: 30 })
		end

	end

end