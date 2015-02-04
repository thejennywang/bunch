require 'rails_helper'

describe VenueDataRetriever do

  context 'generating calls to the API' do

    let(:midpoint) { double :midpoint, lat: 37.801234, lng: -122.401462 }

    it 'can make a request to the foursquare API' do
      data, radius = VenueDataRetriever.request_foursquare_data(midpoint,"food")
      expect(data["response"]["query"]).to eq "food"
      expect(data["response"]).to have_key("suggestedBounds")
    end

    it 'creates 30 venues' do
      data, radius = VenueDataRetriever.request_foursquare_data(midpoint,"food")
      venues = VenueDataRetriever.create_venues(data)
      expect(venues.length).to eq VenueDataRetriever::NUMBER_OF_VENUES
      expect(venues.first).to be_an_instance_of(Venue)
    end
    
  end

  context 'once a list of venues has been populated' do
    let(:venue1) { double :venue, rating: 3.0 }
    let(:venue2) { double :venue, rating: 6.5 }
    let(:venue3) { double :venue, rating: 5.3 }
    let(:venue4) { double :venue, rating: 2.2 }
    let(:venues) { [venue1, venue2, venue3, venue4] }
    let(:data)   { double :data }

    before(:each) { allow(VenueDataRetriever).to receive(:create_venues).and_return(venues) }
    
    it 'sorts the venues by rating' do
      sorted_venues = VenueDataRetriever.sort_by_rating(venues)
      expect(sorted_venues).to eq [venue2, venue3, venue1, venue4]
    end

    it 'selects the three highest rated venues' do
      venues = VenueDataRetriever.select_venues(data)
      expect(venues).to eq [venue2, venue3, venue1]
    end


  end

end



