class NotificationsController < ApplicationController

	def new 

	end

	def create
		# raise 'hello'
		meetup_details = params[:message]
		SMSNotifier.send_meetup_sms(params[:phone_numbers].first.values, meetup_details)
		redirect_to new_midpoint_path
	end

end
