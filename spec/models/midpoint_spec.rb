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

	  context 'when populating addresses' do

	  	let(:midpoint) 	{ Midpoint.new											}
	  	let(:address_1) { {	"address"=>"363 Clementina St",
	 												"full_address"=>"363 Clementina St, San Francisco, CA 94103",
	 												"lat"=>"37.7820662",
													"lng"=>"-122.4522556" } }
			let(:address_2) { {	"address"=>"Green Apple Books",
	 												"full_address"=>" 506 Clement Street, San Francisco, CA 94118",
	 												"lat"=>"37.78316",
	 												"lng"=>"-122.464723" }	}
	  	let(:address_list) {[address_1,address_2]						}

    
	  	it 'can create two addreses from an address list' do
	  		midpoint.add_addresses_from(address_list)
	  		expect(midpoint.addresses.length).to eq 2
	  	end

	  	it 'creates addresses with the full address, longitude and latitude' do
	  		midpoint.add_addresses_from(address_list)
	  		first_address = midpoint.addresses.first
	  		expect(first_address.full_address).to eq "363 Clementina St, San Francisco, CA 94103"
	  		expect(first_address.lat).to eq 37.7820662
	  		expect(first_address.lng).to eq -122.4522556
	  	end

	  	context 'calculating midpoint location' do

	  		let (:location) { double Coordinate, lat: 37.8, lng: -122.4   																}
	  		before(:each) 	{ allow(MidpointCalculator).to receive(:midpoint_by).and_return(location)	}

		  	it 'with valid addresses can determine a midpoint location' do
			  	midpoint.add_addresses_from(address_list)
			  	midpoint.create_location
			  	expect(midpoint.lat).to eq 37.8
			  	expect(midpoint.lng).to eq -122.4
			  end
		  
				it 'can be created with addresses and midpoint from an address list' do
					Midpoint.create_from(address_list)
					expect(Midpoint.first.lat).to eq 37.8
				end

			end

		end

	end
