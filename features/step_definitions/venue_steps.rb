Then(/I should see a venue image/) do
  page.should have_css('.media-grid img.thumbnail')
end

Then(/I should not see a venue image/) do
  page.should have_no_css('.media-grid img.thumbnail')
end

Then(/^there should be (\d+) venues? displayed$/) do |num|
  page.should have_css('#venue_list tr td:first-child', count: num.to_i)
end
