class JsonDataController < ApplicationController

	def show
	  midpoint = Midpoint.find(params[:midpoint_id])
	  @midpoint_coordinates = Coordinate.create_from(midpoint)
	  @address_coordinates = midpoint.addresses.map { |address| Coordinate.create_from(address) }
	end

end
