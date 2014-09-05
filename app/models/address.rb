class Address < ActiveRecord::Base
	
	LATITUDE_RANGE = (-90..90)
	LONGITUDE_RANGE = (-180..180)

	belongs_to :midpoint

	validates :full_address, presence: { message: 'You must include a full address' }
	validates :lat, presence: { message: 'You must include a latitude' }
	validates :lng, presence: { message: 'You must include a longitude' }

	validates :lat, numericality: { message: 'Latitude must be a number' }
	validates :lng, numericality: { message: 'Longitude must be a number' }

	validates :lat, inclusion: { in: LATITUDE_RANGE , message: 'Latitude must be between -90 and 90' }
	validates :lng, inclusion: { in: LONGITUDE_RANGE , message: 'Longitude must be between -180 and 180' }

end
