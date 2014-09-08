require 'rails_helper'

describe MidpointCalculator do

	let(:coord_1)	             { double Coordinate, lat: 0, lng: 0                    }
	let(:coord_2)              { double Coordinate, lat: 30, lng: 40                  }
	let(:coords)	             { [coord_1, coord_2] 									                }
  let(:london_coord_1)       { double Coordinate, lat: 51.507351, lng: -0.127758    }
  let(:london_coord_2)       { double Coordinate, lat: 51.551795, lng: -0.064643    }
  let(:london_coord_3)       { double Coordinate, lat: 51.47002, lng: -0.454295     }
  let(:london_coords)        { [london_coord_1, london_coord_2]                     } 

	it 'should return a coordinate object' do
		expect(MidpointCalculator.midpoint_by(:distance, coords)).to be_an_instance_of(Coordinate)
	end
	
	context 'Distance - two coordinate case' do

		it 'should return coordinates for the equidistant point given 2 other coordinates' do
			expect(MidpointCalculator.midpoint_by(:distance, coords).lat).to eq 15
			expect(MidpointCalculator.midpoint_by(:distance, coords).lng).to eq 20
		end

		it 'should return coordinates for the middle of n coordinates' do
			coord_3 = double Coordinate, lat: 50, lng: 40
			coords << coord_3
			expect(MidpointCalculator.midpoint_by(:distance, coords).lat).to eq 26
			expect(MidpointCalculator.midpoint_by(:distance, coords).lng).to eq 26
		end

	end

	context 'Drive time along a stright line - two coordinate case' do

		it 'should return coordinates for the point of equal drive time between 2 other coordinates' do
			result = MidpointCalculator.midpoint_by(:drive_time, london_coords)
			time_1 = _drive_times(london_coord_1, result).first[0]
			time_2 = _drive_times(london_coord_2, result).first[0]
			expect(time_1).to be_within(MidpointCalculator::TIME_THRESHOLD).of time_2
		end 
		
	end

	context 'Drive time using a grid - two coordinate case' do

    let(:midpoint)	  { MidpointCalculator.midpoint_by(:distance, coords)     }
    
    context 'initial guess locations' do

      let(:location)  { MidpointCalculator.new_location_equidistant_from(coords,10) }
      let(:locations) { MidpointCalculator.locations_equidistant_from(coords)						}

      it 'returns a location which is equidistant between two start points' do
        distance1 = MidpointCalculator.distance_between([coord_1,location])
        distance2 = MidpointCalculator.distance_between([coord_2,location])
        expect(distance1).to eq distance2
      end

       it 'returns a location which is distance 10 from the midpoint' do
        distance = MidpointCalculator.distance_between([midpoint,location])
        expect(distance).to eq 10
      end

      it 'returns an array of locations spaced over a distance A-B' do
        midpoint = MidpointCalculator.midpoint_by(:distance, coords)
        locations_extremes = [locations.first, locations.last]
        extremes_midpoint = MidpointCalculator.midpoint_by(:distance, locations_extremes)
        expect(MidpointCalculator.distance_between([midpoint,extremes_midpoint])).to be_within(0.01).of 0
        expect(MidpointCalculator.distance_between([locations.first,locations.last])).to be_within(0.01).of 50
      end

    end

  end

  context 'Finding minimum drive times' do

    before(:each) { london_coords << london_coord_3 }

    it 'selects the location with the minimum combined driving time' do
      allow(JourneyTimeCalculator).to receive(:drive_times_between).and_return([[20,25],[10,15],[25,5]])
      expect(MidpointCalculator.quickest_location(coords,london_coords, :drive)).to eq london_coord_2
    end

  end

  xcontext 'Drive time using grid - N coordinate case' do

    before(:each) { london_coords << london_coord_3 }

    it 'should return coordinates for a point of equal drive time from the coordinate inputs' do
      result = MidpointCalculator.midpoint_by(:drive_time, london_coords)
      times = JourneyTimeCalculator.times_between(london_coords, [result], :drive).flatten
      expect(times[0]).to be_within(3*MidpointCalculator::TIME_THRESHOLD).of times[1]
      expect(times[1]).to be_within(3*MidpointCalculator::TIME_THRESHOLD).of times[2]
    end

  end

	def _drive_times(origin, destination)
		JourneyTimeCalculator.times_between([origin], [destination], :drive)
	end

end