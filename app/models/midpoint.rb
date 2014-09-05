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

	def get_meeting_places(number: number, type: type)

	end

	def self.create_from(addresses)
		addresses = _create_addresses(addresses)
    coordinates = addresses.map{ |address| Coordinate.create_from(address) }
    midpoint = _create_midpoint_from(coordinates)

    
    _create_associations(midpoint, addresses)
    midpoint
	end

	def self._create_addresses(params)
    addresses = []
    params.length.times { |i| addresses << Address.create(_nth_address_details(i, params)) }
    addresses
  end

  def self._create_associations(midpoint, child_addresses)
    child_addresses.each { |child_address| midpoint.addresses << child_address }
  end

  def self._create_midpoint_from(coordinates, metric=:distance)
    midpoint_coordinates = MidpointCalculator.midpoint_by(metric, coordinates)
    Midpoint.create(lat: midpoint_coordinates.lat, lng: midpoint_coordinates.lng)
  end

  def self._nth_address_details(n, addresses)
    { 
      :full_address => addresses[n]["full_address"], 
      :lat => addresses[n]["lat"].to_f, 
      :lng => addresses[n]["lng"].to_f
    }
  end

end
