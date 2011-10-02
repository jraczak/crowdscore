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
