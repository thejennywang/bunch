Given(/^I have filled in addresses and gone to the map page$/) do
  visit '/'
  fill_in "Address 1", with: "25 City Road"
  fill_in "Address 2", with: "70 Monnow Road"
  click_on "Bunch us"
end

Then(/^the map should have "(.*?)" markers$/) do |n|
  n = n.to_i
  sleep 1
  expect(page.evaluate_script('mainMap.markers.length')).to eq(n)
end

Then(/^I should see a list of venue recommendations$/) do
  expect(page).to have_css('#venue-container')
end

Then(/^I should see "(.*?)" venue details$/) do |count|
  within('#venue-container') { expect(page).to have_css('article', :count => count) }
end