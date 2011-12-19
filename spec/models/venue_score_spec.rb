require 'spec_helper'

describe VenueScore do
  disconnect_sunspot

  subject { Factory.build(:venue_score) }

  it { should be_valid }

  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:venue) }

  it "validates that a venue score cannot be submitted by the same user twice" do
    subject.save!
    v = Factory.build(:venue_score, user: subject.user, venue: subject.venue)
    v.should_not be_valid
  end

  [:score1, :score2, :score3, :score4].each do |attr|
    it { should validate_numericality_of(attr) }
    it { should allow_value(10).for(attr) }
    it { should allow_value("10").for(attr) }
    it { should allow_value(0).for(attr) }
    it { should_not allow_value(11).for(attr) }
    it { should_not allow_value(-1).for(attr) }
    it { should_not allow_value(4.5).for(attr) }
  end

  its(:computed_score) { should_not be }

  context "on save" do
    subject { Factory.build(:venue_score, score1: 10, score2: 8, score3: 9, score4: 6) }
    before { subject.save! }

    its(:computed_score) { should == 83 }
  end

  it "fires off a recompute of the venue's total score" do
    venue = double(Venue)
    venue.should_receive(:recompute_score!)

    subject.stub(:venue) { venue }

    subject.save!
  end
end
