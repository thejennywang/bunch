class VenuesController < ApplicationController

	def show
		@midpoint = Midpoint.find(params[:midpoint_id])
		data = VenueDataRetriever.request_foursquare_data(@midpoint,params[:options])
		@venues = VenueDataRetriever.select_venues(data)
	end

end
