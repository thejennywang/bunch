require 'venue'

describe Venue do 
  let(:venue_information) { }
  it 'creates a name' do
    venue = Venue.create_venue_from(venue_information)
    expect(venue.name).to eq "Nandos"
  end
  

end

