require 'spec_helper'

describe Venue do
  disconnect_sunspot

  it { should belong_to(:venue_category) }
  it { should belong_to(:venue_subcategory) }

  it { should have_many(:venue_images) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:address1) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zip) }
  it { should validate_presence_of(:venue_category) }

  it { should be_active } # by default

  it { should allow_mass_assignment_of(:name) }
  it { should allow_mass_assignment_of(:address1) }
  it { should allow_mass_assignment_of(:address2) }
  it { should allow_mass_assignment_of(:city) }
  it { should allow_mass_assignment_of(:state) }
  it { should allow_mass_assignment_of(:zip) }
  it { should allow_mass_assignment_of(:phone) }
  it { should allow_mass_assignment_of(:url) }
  it { should allow_mass_assignment_of(:venue_category_id) }
  it { should allow_mass_assignment_of(:venue_subcategory_id) }
  it { should allow_mass_assignment_of(:venue_category) }
  it { should allow_mass_assignment_of(:venue_subcategory) }
  it { should_not allow_mass_assignment_of(:active) }
  it { should_not allow_mass_assignment_of(:computed_score) }

  it { should allow_mass_assignment_of(:name).as(:admin) }
  it { should allow_mass_assignment_of(:address1).as(:admin) }
  it { should allow_mass_assignment_of(:address2).as(:admin) }
  it { should allow_mass_assignment_of(:city).as(:admin) }
  it { should allow_mass_assignment_of(:state).as(:admin) }
  it { should allow_mass_assignment_of(:zip).as(:admin) }
  it { should allow_mass_assignment_of(:phone).as(:admin) }
  it { should allow_mass_assignment_of(:url).as(:admin) }
  it { should allow_mass_assignment_of(:venue_category_id).as(:admin) }
  it { should allow_mass_assignment_of(:venue_subcategory_id).as(:admin) }
  it { should allow_mass_assignment_of(:venue_category).as(:admin) }
  it { should allow_mass_assignment_of(:venue_subcategory).as(:admin) }
  it { should allow_mass_assignment_of(:active).as(:admin) }
  it { should_not allow_mass_assignment_of(:computed_score).as(:admin) }

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

  describe ".active scope" do
    it "does not return inactive records" do
      active = Factory.create(:venue, active: true)
      inactive = Factory.create(:venue, active: false)

      Venue.active.should include(active)
      Venue.active.should_not include(inactive)
    end
  end

  describe "#recompute_score!" do
    subject { Factory.create(:venue) }

    it "computes its score from its venue scores" do
      score1 = double(VenueScore, computed_score: 82)
      score2 = double(VenueScore, computed_score: 95)

      subject.stub(:venue_scores).and_return([score1, score2])

      subject.recompute_score!

      subject.computed_score.should == 89
      subject.should be_persisted
    end
  end

  describe ".alphabetical" do
    let!(:first_venue) { Factory(:venue, name: "Zeta") }
    subject { Factory(:venue, name: "Alpha") }

    it "should sort alphabetically" do
      Venue.alphabetical.should == [subject, first_venue]
    end
  end
end
