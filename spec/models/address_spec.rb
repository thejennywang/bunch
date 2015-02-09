require 'rails_helper'

RSpec.describe Address, :type => :model do
  
  context 'validations' do

	  it 'must have a full_address' do
	  	invalid_address = Address.create(lat: 51.0, lng: 0.0)
	  	expect(invalid_address).not_to be_valid
	  	expect(invalid_address.errors.messages[:full_address]).to include('You must include a full address')
	  end

	  it 'must have a latitude' do
	  	invalid_address = Address.create(full_address: '363 Clementina St', lng: 0.0)
	  	expect(invalid_address).not_to be_valid
	  	expect(invalid_address.errors.messages[:lat]).to include('You must include a latitude')
	  end

	  it 'must have a longitude' do
	  	invalid_address = Address.create(full_address: '363 Clementina St', lat: 0.0)
	  	expect(invalid_address).not_to be_valid
	  	expect(invalid_address.errors.messages[:lng]).to include('You must include a longitude')
	  end

	  it 'latitude must be a number' do
	  	invalid_address = Address.create(full_address: '363 Clementina St', lat: 'xyz', lng: 0.0)
	  	expect(invalid_address).not_to be_valid
	  	expect(invalid_address.errors.messages[:lat]).to include('Latitude must be a number')
	  end

	  it 'longitude must be a number' do
	  	invalid_address = Address.create(full_address: '363 Clementina St', lat: 0.0, lng: 'xyz')
	  	expect(invalid_address).not_to be_valid
	  	expect(invalid_address.errors.messages[:lng]).to include('Longitude must be a number')
	  end

	  it 'latitude must be < 90' do
	  	invalid_address = Address.create(full_address: '363 Clementina St', lat: 100, lng: 0.0)
	  	expect(invalid_address).not_to be_valid
	  	expect(invalid_address.errors.messages[:lat]).to include('Latitude must be between -90 and 90')
	  end

	  it 'latitude must be > -90' do
	  	invalid_address = Address.create(full_address: '363 Clementina St', lat: -100, lng: 0.0)
	  	expect(invalid_address).not_to be_valid
	  	expect(invalid_address.errors.messages[:lat]).to include('Latitude must be between -90 and 90')
	  end

	  it 'longitude must be < 180' do
	  	invalid_address = Address.create(full_address: '363 Clementina St', lat: 0, lng: 190)
	  	expect(invalid_address).not_to be_valid
	  	expect(invalid_address.errors.messages[:lng]).to include('Longitude must be between -180 and 180')
	  end

	  it 'longitude must be > -180' do
	  	invalid_address = Address.create(full_address: '363 Clementina St', lat: 0, lng: -190)
	  	expect(invalid_address).not_to be_valid
	  	expect(invalid_address.errors.messages[:lng]).to include('Longitude must be between -180 and 180')
	  end

	  it 'is valid with a text address, numeric latitude (-90, 90) and longitude (-180, 180)' do
	  	valid_address = Address.create(full_address: '363 Clementina St', lat: 0, lng: 0)
	  	expect(valid_address).to be_valid
	  end

  end

end
