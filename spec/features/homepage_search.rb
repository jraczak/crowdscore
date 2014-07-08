require 'spec_helper'

describe "homepage search bar", :sauce => true do
  it "can search for venues" do
    visit "http://crowdscore-staging.herokuapp.com"
      within("div.search-fields") do
        fill_in 'q', :with => "pillows"
        fill_in 'zip', :with => "94404"
        click('Find it')
      end
      page.should have_content "Fluffy Pillows"
  end
end
