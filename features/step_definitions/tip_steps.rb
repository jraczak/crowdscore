Given /^a tip was created yesterday for the venue with text: "([^"]*)"$/ do |text|
  Timecop.travel(1.day.ago) do
    step %Q{a tip was created just now for the venue with text: "#{text}"}
  end
end

Given /^a tip was created just now for the venue with text: "([^"]*)"$/ do |text|
  create_model("the tip", venue: model!("the venue"), text: text)
end

Then /^I should see "([^"]*)" before "([^"]*)"$/ do |first_text, second_text|
  first_id = Tip.find_by_text!(first_text).id
  second_id = Tip.find_by_text!(second_text).id

  page.should have_css("#tip_#{first_id} + #tip_#{second_id}")
end

Given /^"([^"]*)" has been upvoted$/ do |text|
  tip = Tip.find_by_text!(text)
  user = Factory(:user)

  TipLike.create!(tip: tip, user: user)
end

Then /^my upvote for the tip should have been recorded$/ do
  model!("the tip").liked_by.should include(model!("the user"))
end

Given /^I created a tip for the venue with text: "([^"]*)"$/ do |text|
  create_model("the tip", venue: model!("the venue"), text: text, user: model!("the user"))
end

Then /^I should see "([^"]*)" next to the "([^"]*)" tip$/ do |text, tip_name|
  tip = Tip.find_by_text(tip_name)
  find("#tip_#{tip.id}").should have_content(text)
end
