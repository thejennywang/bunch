class VenuesController < ApplicationController

	def create
		@midpoint = Midpoint.find(params[:midpoint_id])
		options = params[:options]
		data = VenueDataRetriever.request_foursquare_data(@midpoint,options)
		@venue = VenueDataRetriever.select_venues(1,data)[0]
		puts "--------------------------------"
		puts @venue.name.inspect
		# render json: {"text"=>"hello"}	
	end

end
