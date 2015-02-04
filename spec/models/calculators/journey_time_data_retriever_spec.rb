require 'rails_helper'

describe JourneyTimeDataRetriever do

	let(:origin) 				{ double Coordinate, lat: 37.78316, lng: -122.464723 	  }
	let(:destination) 	{ double Coordinate, lat: 37.7820662, lng: -122.4522556  }
	let(:origins)				{ [origin]																					   	}
	let(:destinations) 	{ [destination]																			   	}

	context 'generating calls to API' do

		it 'should make a request to the Distance Matrix API' do
			query_string = 'https://maps.googleapis.com/maps/api/distancematrix/json?origins=37.78316,-122.464723'\
			'&destinations=37.7820662,-122.4522556&mode=driving&key=' + JourneyTimeDataRetriever::API_KEY
			expect(JourneyTimeDataRetriever).to receive(:fetch_json_from).with(query_string)
			JourneyTimeCalculator.times_between(origins, destinations, :drive)
		end

		it 'a request response should include journey time and status' do
			url = JourneyTimeDataRetriever.build_url(origins, destinations)
			expect(JourneyTimeDataRetriever.fetch_json_from(url)['rows'][0]['elements'][0]).to have_key("duration")
			expect(JourneyTimeDataRetriever.fetch_json_from(url)).to include("status" => "OK")
		end

	end

end