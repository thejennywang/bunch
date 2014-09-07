require 'rails_helper'

describe Venue do

  let(:venue_information) { {
    "id"=>"4ad5c5cef964a5206f0321e3", 
    "name"=>"Nandos", 
    "location"=>{"address"=>"26 St John St.", "lat"=>51.52037998756202, "lng"=>-0.10146260261535645, "formattedAddress"=>["26 St John St.", "London", "Greater London", "EC1M 4AY", "United Kingdom"]}, 
    "categories"=>[{"name"=>"Gastropub"}], 
    "price"=>{"tier"=>3}, 
    "rating"=>9.2 }
  }

  context 'when created'

  it 'has a name' do
    venue = Venue.new(venue_information)
    expect(venue.name).to eq "Nandos"
  end

  it 'has an address' do
    venue = Venue.new(venue_information)
    expect(venue.address).to eq ["26 St John St.", "London", "Greater London", "EC1M 4AY", "United Kingdom"]
  end

  
end

