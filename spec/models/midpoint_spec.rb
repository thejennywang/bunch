require 'rails_helper'

RSpec.describe Midpoint, :type => :model do

	  context 'validations' do

		  it 'must have a latitude' do
		  	invalid_mid = Midpoint.create(lng: 0.0)
		  	expect(invalid_mid).not_to be_valid
		  	expect(invalid_mid.errors.messages[:lat]).to include('You must include a latitude')
		  end

		  it 'must have a longitude' do
		  	invalid_mid = Midpoint.create(lat: 0.0)
		  	expect(invalid_mid).not_to be_valid
		  	expect(invalid_mid.errors.messages[:lng]).to include('You must include a longitude')
		  end

		  it 'latitude must be a number' do
		  	invalid_mid = Midpoint.create(lat: 'xyz', lng: 0.0)
		  	expect(invalid_mid).not_to be_valid
		  	expect(invalid_mid.errors.messages[:lat]).to include('Latitude must be a number')
		  end

		  it 'longitude must be a number' do
		  	invalid_mid = Midpoint.create(lat: 0.0, lng: 'xyz')
		  	expect(invalid_mid).not_to be_valid
		  	expect(invalid_mid.errors.messages[:lng]).to include('Longitude must be a number')
		  end

		  it 'latitude must be < 90' do
		  	invalid_mid = Midpoint.create(lat: 100, lng: 0.0)
		  	expect(invalid_mid).not_to be_valid
		  	expect(invalid_mid.errors.messages[:lat]).to include('Latitude must be between -90 and 90')
		  end

		  it 'latitude must be > -90' do
		  	invalid_mid = Midpoint.create(lat: -100, lng: 0.0)
		  	expect(invalid_mid).not_to be_valid
		  	expect(invalid_mid.errors.messages[:lat]).to include('Latitude must be between -90 and 90')
		  end

		  it 'longitude must be < 180' do
		  	invalid_mid = Midpoint.create(lat: 0, lng: 190)
		  	expect(invalid_mid).not_to be_valid
		  	expect(invalid_mid.errors.messages[:lng]).to include('Longitude must be between -180 and 180')
		  end

		  it 'longitude must be > -180' do
		  	invalid_mid = Midpoint.create(lat: 0, lng: -190)
		  	expect(invalid_mid).not_to be_valid
		  	expect(invalid_mid.errors.messages[:lng]).to include('Longitude must be between -180 and 180')
		  end

		  it 'can have addresses' do
		  	address = Address.create(full_address: 'street', lat: 0, lng: 0)
		  	mid = Midpoint.create(lat: 0, lng: 0)
		  	mid.addresses << address
		  	expect(mid.addresses).to include(address)
		  end

		  it 'is valid with a numeric latitude (-90, 90) and longitude (-180, 180)' do
		  	valid_mid = Midpoint.create(lat: 0, lng: 0)
		  	expect(valid_mid).to be_valid
		  end

	  end

	  context 'with a valid lat and lng' do
	  	it 'can find nearby meeting places' do
	  		midpoint = Midpoint.create(lat: 51, lng: -0.12)
	  		midpoint.get_meeting_places(number: 5, type: "food")
	  	end
	  end
  
end
