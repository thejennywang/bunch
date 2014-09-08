require 'rails_helper'

describe Venue do

  let(:venue_information) { {
    "id"=>"4ad5c5cef964a5206f0321e3", 
    "name"=>"Nandos", 
    "location"=>{"address"=>"26 St John St.", "lat"=>51.52037998756202, "lng"=>-0.10146260261535645, "formattedAddress"=>["26 St John St.", "London", "Greater London", "EC1M 4AY", "United Kingdom"]}, 
    "categories"=>[{"name"=>"Gastropub", 
      "icon"=> {
        "prefix"=> "https://ss1.4sqi.net/img/categories_v2/food/gastropub_",
        "suffix"=> ".png"
        }}], 
    "price"=>{"tier"=>3}, 
    "rating"=>9.2 } 
  }

  let(:venue) { Venue.new(venue_information) }

  context 'when created' do

    it 'has a name' do
      expect(venue.name).to eq "Nandos"
    end

    it 'has an address' do
      expect(venue.full_address).to eq ["26 St John St.", "London", "Greater London", "EC1M 4AY", "United Kingdom"]
    end

    it 'has an latitude and a longtiude' do
      expect(venue.lat).to eq 51.52037998756202
      expect(venue.lng).to eq -0.10146260261535645
    end

    it 'has a category' do
      expect(venue.category).to eq 'Gastropub'
    end

    it 'has a price tier' do
      expect(venue.price_tier).to eq 3
    end

    it 'has a rating' do
      expect(venue.rating).to eq 9.2
    end

    it 'has an id' do
      expect(venue.id).to eq "4ad5c5cef964a5206f0321e3"
    end

    it 'has an icon' do
      expect(venue.icon).to eq "https://ss1.4sqi.net/img/categories_v2/food/gastropub_bg_44.png"
    end

  end

  context 'missing information' do

    before(:each) { venue_information.delete('price') }

    it 'should return N/A for any missing fields' do
      expect(venue.price_tier).to eq "N/A"

    end

  end

  
end


