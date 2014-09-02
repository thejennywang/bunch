require 'calculators/journey_time_calculator'

describe JourneyTimeCalculator do
	
	context 'Requesting a journey time between origin and destination' do

		let(:origin) 			{ double Coordinate, lat: 51.507351, lng: -0.127758 }
		let(:destination) { double Coordinate, lat: 51.551795, lng: -0.064643 }
		let(:origins)			{ [origin]																					}

		context 'generating calls to API' do

			it 'should make a request to the Distance Matrix API' do
				query_string = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=51.507351,-0.127758'\
				'&destinations=51.551795,-0.064643&mode=driving&key=AIzaSyCUkhykgT6lp7l8D7PNr1TnwQ8oHu4jLwE'
				expect(JourneyTimeCalculator).to receive(:fetch_json_from).with(query_string)
				JourneyTimeCalculator.drive_times_between(origins, destination)
			end

			it 'a request response should include journey time and status' do
				url = JourneyTimeCalculator.build_url(origins, destination)
				expect(JourneyTimeCalculator.fetch_json_from(url)['rows'][0]['elements'][0]).to have_key("duration")
				expect(JourneyTimeCalculator.fetch_json_from(url)).to include("status" => "OK")
			end

		end

		context 'retrieving journey times' do
			
			it 'should return a time given an origin and a destination' do
				expect(JourneyTimeCalculator.drive_times_between(origins, destination).first).to be_within(600).of(1200)
			end

			it 'should return two times given two origins and one destination' do
				origin_2 = double Coordinate, lat: 51.4, lng: -0.13
				origins << origin_2
				expect(JourneyTimeCalculator.drive_times_between(origins, destination).first).to be_within(600).of(1200)
				expect(JourneyTimeCalculator.drive_times_between(origins, destination).last).to be_within(600).of(2200)		
			end
	
		end

	end
	
end


