require 'spec_helper'

describe Tip do
  subject { Factory.build(:tip) }

  it { should validate_presence_of(:venue) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:text) }

  it { should allow_value("t").for(:text) }
  it { should allow_value("t" * 100).for(:text) }
  it { should_not allow_value("t" * 101).for(:text) }

  it "validates that a venue score cannot be submitted by the same user twice" do
    subject.save!
    t = Factory.build(:tip, user: subject.user, venue: subject.venue)
    t.should_not be_valid
  end
end
