class NotificationsController < ApplicationController

	def new 
		@meetup_url = params[:options]
	end

	def create
		meetup_details = generate_meetup_details(params)
		SMSNotifier.send_meetup_sms(params[:phone_numbers].first.values, meetup_details)
		redirect_to new_midpoint_path
	end

	def generate_meetup_details(params)
		"#{params[:message]}\n Venue details: #{params[:meetup_url]}\nPowered by ©bunch 2014" 
	end

end
