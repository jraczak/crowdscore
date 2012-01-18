require 'spec_helper'

describe VenueImage do
  disconnect_sunspot

  subject { Factory.build(:venue_image) }

  it { should be_valid }

  it { should belong_to(:venue) }
  it { should validate_presence_of(:venue) }

  # Something about the way Carrierwave works prevents us from just resetting
  # attachment to nil, so shoulda won't work.
  it "requires an attachment" do
    Factory.build(:venue_image_without_image_file).should_not be_valid
  end
end
