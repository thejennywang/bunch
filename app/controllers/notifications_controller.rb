class NotificationsController < ApplicationController

	def create
		send_notification(params, generate_meetup_details(params))
		redirect_to new_midpoint_path
	end

	def generate_meetup_details(params)
		"'#{params[:message]}'\n- #{params[:user_name]} bunched you!\nMeet @ #{params[:meetup_venue]} @ #{params[:meetup_time]}\nVenue details: #{params[:meetup_url]}\nPowered by ©bunch" 
	end

	def send_notification(params, meetup_details)
		SMSNotifier.send_meetup_sms(params[:phone_numbers].split(','), meetup_details)
	end

end
