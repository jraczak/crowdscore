When /^I confirm the dialog$/ do
    page.driver.browser.switch_to.alert.accept
end

When /^I cancel the dialog$/ do
    page.driver.browser.switch_to.alert.dismiss
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

When /^I leave the "([^"]*)" field blank$/ do |field_name|
  fill_in field_name, with: ""
end

When /^I select nothing from the "([^"]*)" dropdown$/ do |field_name|
  select "", from: field_name
end
