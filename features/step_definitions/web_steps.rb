Given(/^I am on the homepage$/) do
  visit '/'
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
	fill_in arg1, with: arg2
end

When(/^I click "(.*?)"$/) do |arg1|
  click_on arg1
end

Then(/^the address of the midpoint should be displayed$/) do
  expect(page).to have_content("20 Brick Lane")
end

Then(/^"(.*?)" should be displayed$/) do |arg1|
  expect(page).to have_content(arg1)
end

Then(/^a map should be displayed with "(.*?)" origins$/) do |n|
  expect(page).to _have_map
  expect(page.evaluate_script('mainMap.markers.length')).to eq(n.to_i)
end

Then(/^I should see a new address field$/) do
  expect(page).to have_css('#address_3')
end

Given(/^there are five address fields$/) do
  3.times { click_on '+'}
end

Then(/^the \+ button is disabled$/) do
  expect(page).to have_css('a#new-address-form.disabled')
  click_on '+'
  expect(page).not_to have_css('#address_6')
end

Given(/^I have filled in addresses and gone to the map page$/) do
  visit '/'
  fill_in "Address 1", with: "25 City Road"
  fill_in "Address 2", with: "70 Monnow Road"
  click_on "Bunch us"
end

Then(/^the map should have "(.*?)" markers$/) do |n|
  n = n.to_i
  expect(page.evaluate_script('mainMap.markers.length')).to eq(n)
end

Then(/^I should see a list of venue recommendations$/) do
  expect(page).to have_css('#venue-container')
end

Then(/^I should see "(.*?)" venue details$/) do |count|
  within('#venue-container') { expect(page).to have_css('article', :count => count) }
end

def _have_map
	have_css('.gm-style')
end
