Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
	fill_in arg1, with: arg2
end

When(/^I click "(.*?)"$/) do |arg1|
  click_button arg1
end

Then(/^the address of the midpoint should be displayed$/) do
  expect(page).to have_content("20 Brick Lane")
end


When(/^I submit bunch with one address outside London$/) do
  pending # express the regexp above with the code you wish you had
end


Then(/^"(.*?)" should be displayed$/) do |arg1|
  expect(page).to have_content(arg1)
end