When /^I fill out the add a venue form for "(.+)"$/ do |name|
  visit "/venues"
  click_link "Add a venue"
  fill_in "Name", with: name
  fill_in "Address 1", with: "123 Main St"
  fill_in "City", with: "Denver"
  fill_in "State", with: "CO"
  fill_in "Zip code", with: "80202"
  select "Restaurant", from: "Category"
end

Then(/I should see a venue image/) do
  page.should have_css('.media-grid img.thumbnail')
end

Then(/I should not see a venue image/) do
  page.should have_no_css('.media-grid img.thumbnail')
end

Then(/^there should be (\d+) venues? displayed$/) do |num|
  page.should have_css('#venue_list tr td:first-child', count: num.to_i)
end

Then(/^the venue (\w+) should be "(.*)"$/) do |field, value|
  page.should have_xpath("//dt[.='#{field.capitalize}']/following-sibling::*[1][self::dd[.='#{value}']]")
end
