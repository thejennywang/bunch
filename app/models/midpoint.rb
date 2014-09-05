require_relative 'calculators/midpoint_calculator'

class Midpoint < ActiveRecord::Base
  
  LATITUDE_RANGE = (-90..90)
	LONGITUDE_RANGE = (-180..180)

  has_many :addresses

	validates :lat, presence: { message: 'You must include a latitude' }
	validates :lng, presence: { message: 'You must include a longitude' }

	validates :lat, numericality: { message: 'Latitude must be a number' }
	validates :lng, numericality: { message: 'Longitude must be a number' }

	validates :lat, inclusion: { in: LATITUDE_RANGE , message: 'Latitude must be between -90 and 90' }
	validates :lng, inclusion: { in: LONGITUDE_RANGE , message: 'Longitude must be between -180 and 180' }


	def self.create_from(address_list)
		Midpoint.create.add_addresses_from(address_list).create_location

	end

	def add_addresses_from(address_list)
    address_list.map { |address| addresses << Address.create(full_address: address["full_address"], lat: address["lat"], lng: address["lng"]) }
    self
	end

# This is where you can change which midpoint calculator to use
	def create_location
		start_coordinates = addresses.map{ |address| Coordinate.create_from(address) }
    midpoint_coordinates = MidpointCalculator.midpoint_by(:distance, start_coordinates)
    self.update(lat: midpoint_coordinates.lat, lng: midpoint_coordinates.lng)
		self
	end


end
