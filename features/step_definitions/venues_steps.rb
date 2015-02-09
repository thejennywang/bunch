Given(/^I have filled in addresses and gone to the map page$/) do
  visit '/'
  fill_in "Address 1", with: "363 Clementina St"
  fill_in "Address 2", with: "506 Clement Street"
  click_on "Bunch us"
end

When(/^I click on the drinks icon$/) do
  page.find('.fa-glass').click
end

Then(/^I should see a fresh set of recommendations on the map$/) do
  expect { page.find('.fa-glass').click }.to change{ page.all('.venue-name') }
end

Then(/^I should see a list of venue recommendations$/) do
  expect(page).to have_css('#venue-container')
end

Then(/^I should see "(.*?)" venue details$/) do |count|
  within('#venue-container') { expect(page).to have_css('article', :count => count) }
end

Then(/^I should see "(.*?)" venue markers on the map$/) do |n|
  venue_marker_count = page.evaluate_script('mainMap.markers.filter(function(marker) { return marker.class === "venue-marker"; }).length;')
  expect(venue_marker_count).to eq(n.to_i)
end