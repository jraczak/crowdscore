require 'spec_helper'

describe VenueCategory do
  it { should have_many(:venues) }
  it { should have_many(:venue_subcategories) }

  it { should validate_presence_of(:name) }

  it "has a default scope that organizes alphabetically" do
    Factory.create(:venue_category, :name => "Test")
    Factory.create(:venue_category, :name => "One")
    Factory.create(:venue_category, :name => "Two")
    Factory.create(:venue_category, :name => "Three")

    VenueCategory.all.map(&:name).should == ['One', 'Test', 'Three', 'Two']
  end
end
