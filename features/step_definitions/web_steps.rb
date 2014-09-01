Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
	fill_in arg1, with: arg2
end

When(/^I click ‘Bunch’$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see the midpoint displayed on the map$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I submit bunch with one address outside London$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I will see an error message$/) do
  pending # express the regexp above with the code you wish you had
end
