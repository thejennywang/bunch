class SMSNotifier

	DEFAULT_NUMBER = '+441539234045'
	ACCOUNT_SID = Rails.application.secrets.twilio_account_sid
	AUTH_TOKEN = Rails.application.secrets.twilio_auth_token

	attr_accessor :number

	def initialize(number = DEFAULT_NUMBER)
		@number = number
	end

	def send_meetup_sms(numbers, venue)
		initialize_twilio_client
		message_body = 'Hi'
		nunbers.each { |number| create_new_twilio_msg(number, message_body) }
	end

	def initialize_twilio_client
		@client = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
	end
			
	def create_new_twilio_msg(customer_number, message_body)
		@client.account.messages.create({
			:from => DEFAULT_NUMBER, 
			:to => customer_number,
			:body => message_body
		})
	end

end