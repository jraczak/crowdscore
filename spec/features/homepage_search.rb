require 'spec_helper'

describe "homepage search bar", :sauce => true, :js => true do
  it "can search for venues" do
    STDERR.puts "Starting test"
    visit "http://crowdscore-staging.herokuapp.com"
    STDERR.puts "Visited page"
    fill_in 'q', :with => "pillows"
    STDERR.puts "Found Query"
    fill_in 'zip', :with => "94404"
    click_button "Find it"
    
    page.should have_content "Fluffy Pillows"
  end
end