Given(/^I am on the homepage$/) do
  visit '/'
end

Given(/^I have filled in 2 addresses$/) do 
  fill_in "Address 1", with: "363 Clementina St"
  fill_in "Address 2", with: "506 Clement Street"
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |arg1, arg2|
  fill_in arg1, with: arg2
end

When(/^I click "(.*?)"$/) do |arg1|
  click_on arg1
end

When(/^I fill in another address$/) do
end

And(/^submit a blank address$/) do
  fill_in "Address 3", with: ""
  click_on 'Bunch us'
end

Then(/^I should see 2 address fields$/) do  
  expect(page).to have_field 'Address 1'
  expect(page).to have_field 'Address 2'
end

Then(/^the address of the midpoint should be displayed$/) do
  expect(page).to have_content("20 Brick Lane")
end

Then(/^"(.*?)" should be displayed$/) do |arg1|
  expect(page).to have_content(arg1)
end

Then(/^a map should be displayed with "(.*?)" origins$/) do |n|
  expect(page).to _have_map
  origin_marker_count = page.evaluate_script('mainMap.markers.filter(function(marker) { return marker.class === "address-marker"; }).length;')
  expect(origin_marker_count).to eq(n.to_i)
end

Then(/^I should see a new address field$/) do
  expect(page).to have_css('#address_3')
end

Then(/^then adding an address is disabled$/) do
  expect(page).to have_css('a#new-address-form.disabled',visible: false)
end

def _have_map
	have_css('.gm-style')
end
