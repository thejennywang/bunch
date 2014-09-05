require 'rails_helper'

describe Venue do

  context 'generating calls to the API' do

    let(:midpoint) {double :midpoint, lat: 51.520379, lng: -0.101462}

    it 'should make a request to the foursqaure API' do
      data = Venue.request_foursquare_data(midpoint,"food")
      expect(data["response"]["query"]).to eq "food"
      expect(data["response"]["fallbackCategory"]["target"]["params"]["ll"]).to eq "51.520379,-0.101462"

    end

  end

  context 'retreiving the data from the API call' do

    let(:venue_information) { {
      "id"=>"4ad5c5cef964a5206f0321e3", 
      "name"=>"Nandos", 
      "location"=>{"address"=>"26 St John St.", "lat"=>51.52037998756202, "lng"=>-0.10146260261535645, "formattedAddress"=>["26 St John St.", "London", "Greater London", "EC1M 4AY", "United Kingdom"]}, 
      "categories"=>[{"name"=>"Gastropub"}], 
      "price"=>{"tier"=>3}, 
      "rating"=>9.2 }
    }

    it 'creates a name' do
      venue = Venue.new(venue_information)
      expect(venue.name).to eq "Nandos"
    end

    

  end

  
end

