class JsonDataController < ApplicationController

	def show
	  midpoint = Midpoint.find(params[:midpoint_id])
	  @midpoint_coordinates = Coordinate.create_from(midpoint)
	  @address_coordinates = midpoint.addresses.map { |address| Coordinate.create_from(address) }
	  @coordinate_data = [ @midpoint_coordinates, @address_coordinates ]
	end

end
