class NotificationsController < ApplicationController

	def new 
		# @meetup_url = params[:options]
	end

	def create
		# raise params
		send_notification(params, generate_meetup_details(params))
		redirect_to new_midpoint_path
	end

	def generate_meetup_details(params)
		"#{params[:user_name]} bunched you!\n#{params[:message]}\nMeet @ #{params[:meetup_time]}\nVenue details: #{params[:meetup_url]}\nPowered by ©bunch 2014" 
	end

	def send_notification(params, meetup_details)
		SMSNotifier.send_meetup_sms(params[:phone_numbers].split(','), meetup_details)
	end

end
