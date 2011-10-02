require 'spec_helper'

describe Venue do
  it { should belong_to(:venue_category) }
  it { should belong_to(:venue_subcategory) }

  it { should have_many(:venue_images) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address1) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:venue_category) }

  describe "#full_category_name" do
    let!(:category) { Factory.create(:venue_category, name: "Restaurant") }

    context "when a subcategory is not set" do
      subject { Factory.build(:venue, venue_category: category) }
      its(:full_category_name) { should == "Restaurant" }
    end

    context "when a subcategory is set" do
      let!(:subcategory) { Factory.create(:venue_subcategory, name: "Buffet") }
      subject { Factory.build(:venue, venue_category: category, venue_subcategory: subcategory) }
      its(:full_category_name) { should == "Restaurant - Buffet" }
    end
  end
end
