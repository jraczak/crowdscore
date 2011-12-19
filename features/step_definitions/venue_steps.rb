When /^I fill out the add a venue form for "(.+)"$/ do |name|
  visit "/venues"
  click_link "Add a venue"
  fill_in "Name", with: name
  fill_in "Address 1", with: "123 Main St"
  fill_in "City", with: "Denver"
  select "Colorado", from: "State"
  fill_in "Zip code", with: "80202"
  select "Restaurant", from: "Category"
end

Then(/I should see a venue image/) do
  page.should have_css('.images img')
end

Then(/I should not see a venue image/) do
  page.should have_no_css('.images img')
end

Then(/^there should be (\d+) venues? displayed$/) do |num|
  page.should have_css('#venue_list tr td:first-child', count: num.to_i)
end

Then(/^the venue (\w+) should be "(.*)"$/) do |field, value|
  page.should have_xpath("//dt[.='#{field.capitalize}']/following-sibling::*[1][self::dd[.='#{value}']]")
end

Then /^I should see a tip by me that says "([^"]*)"$/ do |tip_text|
  name = model!("the user").username
  page.should have_content("#{name} said: \"#{tip_text}\"")
end
