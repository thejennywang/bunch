class VenuesController < ApplicationController

	FOURSQUARE_ID = Rails.application.secrets.foursquare_client_id
	FOURSQUARE_SECRET = Rails.application.secrets.foursquare_client_secret

	def create
		@midpoint = Midpoint.find(params[:midpoint_id])
		options = params[:options]
		url = _build_foursquare_url(@midpoint, options)
		data = _fetch_json_from(url)                        
		data['response']['groups'][0]['items'][0]['venue'].inspect                                              
		render json: data['response']['groups'][0]['items'][0]['venue']
	end


	
end
