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

Then(/^a map should be displayed with "(.*?)" origins and a midpoint$/) do |n|
  n = n.to_i + 1
  expect(page).to _have_map
  expect(page.evaluate_script('mainMap.markers.length')).to eq(n)
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

def _have_map
	have_css('.gm-style')
end
