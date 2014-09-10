require 'rails_helper'

describe SMSNotifier do
  it 'sends an sms' do
    number = ["12345678901"]
    meetup_details = "Hello"
    expect(SMSNotifier).to receive(:create_new_twilio_msg).with(number.first, meetup_details)

    SMSNotifier.send_meetup_sms(number, meetup_details)
  end

  it 'sends an sms to all numbers' do
    numbers = ["12345678901", "12345678902"]
    meetup_details = "Hello"
    expect(SMSNotifier).to receive(:create_new_twilio_msg).twice
    SMSNotifier.send_meetup_sms(numbers, meetup_details)
  end
end