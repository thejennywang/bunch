require 'rails_helper'

describe VenueDataRetriever do

  context 'generating calls to the API' do

    let(:midpoint) { double :midpoint, lat: 51.520379, lng: -0.101462 }

    it 'can make a request to the foursqaure API' do
      data = VenueDataRetriever.request_foursquare_data(midpoint,"food")
      expect(data["response"]["query"]).to eq "food"
      expect(data["response"]["fallbackCategory"]["target"]["params"]["ll"]).to eq "51.520379,-0.101462"

    end

    it 'can choose 3 venues' do

    end
    
  end

end



