class VenuesController < ApplicationController

	def create
		@midpoint = Midpoint.find(params[:midpoint_id])
		options = params[:options]
		@venue = VenueDataRetriever.select_venues(1,request_foursquare_data(@midpoint,options))[0]
	end

end
