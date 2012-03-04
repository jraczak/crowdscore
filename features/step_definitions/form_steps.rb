Then /^I should not see a form field labeled "([^"]*)"$/ do |text|
  page.should have_no_text(text)
end
