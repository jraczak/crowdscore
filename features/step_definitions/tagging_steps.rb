Given /^"([^"]*)" has the "([^"]*)" tag$/ do |venue_name, tag|
  venue = Venue.find_by_name(venue_name)

  tag_array = tag.split(" ")
  tag_category_text, tag_text = tag_array[0], tag_array[1..-1]

  tag_category = TagCategory.find_or_create_by_name(tag_category_text)
  tag = Factory.create(:tag, tag_category: tag_category, name: tag_text.join(" "))

  venue.tags << tag
end

Then /^I should see the "([^"]*)" tag heading$/ do |heading|
  page.should have_css('.modal.in h2', content: heading)
end

Then /^I should see the "([^"]*)" tag$/ do |tag|
  page.should have_css('.modal.in li', content: tag)
end

Then /^I should see "([^"]*)" under the "([^"]*)" tag heading$/ do |expected_tag, heading|
  find('.modal.in h2', content: heading).should have_css("li", content: expected_tag)
end

When /^I select "([^"]*)" from the tag category dropdown$/ do |option|
  page.find('select#tag_category_id').select(option)
end

When /^I select "([^"]*)" from the tag dropdown$/ do |option|
  page.find('select#tag_id').select(option)
end
