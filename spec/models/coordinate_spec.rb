require 'coordinate'

describe Coordinate do
	
	context 'coordinate specifications' do
		let(:coordinate) { Coordinate.new(50, 20)}

		it 'should have a latitude' do
			expect(coordinate.lat).to eq 50
		end

		it 'should be able to set a latitude' do
			coordinate.lat = 10
			expect(coordinate.lat).to eq 10
		end

		it 'should have a longitude' do
			expect(coordinate.lng).to eq 20
		end

		it 'should be able to set a longitude' do
			coordinate.lng = 5
			expect(coordinate.lng).to eq 5
		end

	end	

end