Given(/^I have chosen a meeting place$/) do
  visit '/'
  fill_in "Address 1", with: "25 City Road"
  fill_in "Address 2", with: "70 Monnow Road"
  click_on "Bunch us"
end

When(/^I click the phone button$/) do
  click_link '.sms-link'
end

When(/^I fill in my friends' details$/) do
  fill_in 'Phone 1', with: '123456789'
  fill_in 'Phone 2', with: '0987654321'
  click_on 'Meet'
end

Then(/^all the group receive a text with the meeting details$/) do
	expect(SMSNotifier).to receive(:send_meetup_sms).twice.with(['123456789', '0987654321'])
end