class VenuesController < ApplicationController

	def show
		@midpoint = Midpoint.find(params[:midpoint_id])
		options = params[:options]
		data = VenueDataRetriever.request_foursquare_data(@midpoint,options)
		@venues = VenueDataRetriever.select_venues(3,data)
		puts "--------------------------------"
		# render json: {"text"=>"hello"}	
	end

end
