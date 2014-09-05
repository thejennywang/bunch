class VenuesController < ApplicationController

	FOURSQUARE_ID = Rails.application.secrets.foursquare_client_id
	FOURSQUARE_SECRET = Rails.application.secrets.foursquare_client_secret

	def create
		@midpoint = Midpoint.find(params[:midpoint_id])
		options = params[:options]
		url = _build_foursquare_url(@midpoint, options)
		data = _fetch_json_from(url)                          
		# puts data['response']['groups'][0]['items'][0]['venue']['name'].inspect                                              
		render json: data['response']['groups'][0]['items'][0]['venue']
	end

	def _build_foursquare_url(midpoint, options="")
		base_url = 'https://api.foursquare.com/v2/venues/explore?'
		keys = 'client_id=' + FOURSQUARE_ID + '&client_secret=' + FOURSQUARE_SECRET
		location = '&v=20130815&ll=' + @midpoint.lat.to_s + ',' + @midpoint.lng.to_s
    options = '&radius=1000' + '&section=' + options

    foursquare_api_url = base_url + keys + location + options
	end

	def _fetch_json_from(url)
		data = Net::HTTP.get(URI.parse(URI.encode(url)))
		JSON.parse(data)
	end
	
end
