require 'twilio-ruby'

class SMSNotifier

	DEFAULT_NUMBER = Rails.application.secrets.twilio_phone_number
	ACCOUNT_SID = Rails.application.secrets.twilio_account_sid
	AUTH_TOKEN = Rails.application.secrets.twilio_auth_token

	attr_accessor :number

	def self.send_meetup_sms(numbers, meetup_details)
		initialize_twilio_client
		message_body = meetup_details
		numbers.each { |number| create_new_twilio_msg(number, message_body) }
	end

	def self.initialize_twilio_client
		@client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
	end
			
	def self.create_new_twilio_msg(number, message_body)
		@client.account.messages.create({
			:from => DEFAULT_NUMBER, 
			:to => number,
			:body => message_body
		})
	end

end