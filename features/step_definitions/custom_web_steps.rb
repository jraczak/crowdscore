When /^I sleep for (\d+) seconds?$/ do |num|
  sleep num.to_i
end

When /^I confirm the alert that says "(.+)"$/ do |message|
  page.driver.browser.switch_to.alert.text.should == message
  page.driver.browser.switch_to.alert.accept
end

When /^I confirm the dialog$/ do
    page.driver.browser.switch_to.alert.accept
end

When /^I cancel the dialog$/ do
    page.driver.browser.switch_to.alert.dismiss
end

When /^I leave the "([^"]*)" field blank$/ do |field_name|
  fill_in field_name, with: ""
end

When /^I select nothing from the "([^"]*)" dropdown$/ do |field_name|
  page.find(:select, field_name).find('option:first-child').select_option
end

Then /^a dialog should pop up with "(.+)"$/ do |msg|
  page.driver.browser.switch_to.alert.text.should == msg
end

Then /^"([^"]*)" should( not)? be an option for "([^"]*)"$/ do |value, negate, field|
  expectation = negate ? :should_not : :should
  field_labeled(field).first(:xpath, ".//option[text() = '#{value}']").send(expectation, be_present)
end

Then /^(.*) should be visible$/ do |field|
  page.should have_css(selector_for(field), visible: true)
end

Then /^(.*) should not be visible$/ do |field|
  page.should have_no_css(selector_for(field), visible: true)
end

Then /^I should see "([^"]*)" in the lists modal$/ do |text|
  find("#lists-modal").should have_content(text)
end

Then /^I should see "([^"]*)" in the tag modal$/ do |text|
  find("#tag-modal").should have_content(text)
end

Then /^I should see "([^"]*)" in the modal$/ do |text|
  find(".modal").should have_content(text)
end

When "I click to go to the next page" do
  all('.pagination li.next').first.find('a').click
end
