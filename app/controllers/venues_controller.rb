class VenuesController < ApplicationController

	def create
		@midpoint = Midpoint.find(params[:midpoint_id])
		options = params[:options]
		VenueDataRetriever.request_foursquare_data(@midpoint,options)
	end

end
