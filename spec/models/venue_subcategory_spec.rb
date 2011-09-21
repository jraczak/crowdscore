require 'spec_helper'

describe VenueSubcategory do
  it { should belong_to :venue_category }
  it { should have_many :venues }

  it { should validate_presence_of :name }
  it { should validate_presence_of :venue_category }

  it "has a default scope that organizes alphabetically" do
    Factory.create(:venue_subcategory, :name => "Test")
    Factory.create(:venue_subcategory, :name => "One")
    Factory.create(:venue_subcategory, :name => "Two")
    Factory.create(:venue_subcategory, :name => "Three")

    VenueSubcategory.all.map(&:name).should == ['One', 'Test', 'Three', 'Two']
  end
end
