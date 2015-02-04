Given(/^I have chosen a meeting place$/) do
  visit '/'
  fill_in "Address 1", with: "363 Clementina St"
  fill_in "Address 2", with: "506 Clement Street"
  click_on "Bunch us"
end

When(/^I click the phone button$/) do
  	click_link('SMS', :match => :first)
end

When(/^I fill in my friends' details$/) do
  fill_in 'Your name', with: 'Jeremy'
  fill_in 'Phone numbers', with: '123456789,'
  fill_in 'Your message...', with: 'Hi'
  page.find('.glyphicon-calendar').click
end

Then(/^all the group receive a text with the meeting details$/) do
	sms_count = 0
	allow(SMSNotifier).to receive(:send_meetup_sms)  { sms_count += 1 }
  click_button 'Meet'
  expect(sms_count).to eq 1
end